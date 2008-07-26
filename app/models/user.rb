require 'digest/sha1'

class User < ActiveRecord::Base
  has_many :watches, :dependent => :delete_all, :order => 'name ASC'
  
  # Virtual attribute for the unencrypted password
  attr_accessor :password

  validates_presence_of     :email
  validates_presence_of     :password,                   :if => :password_required?
  validates_presence_of     :password_confirmation,      :if => :password_required?
  validates_length_of       :password, :within => 4..40, :if => :password_required?
  validates_confirmation_of :password,                   :if => :password_required?
  validates_length_of       :email,    :within => 3..100
  validates_uniqueness_of   :email, :case_sensitive => false
  validates_format_of       :email,
                            :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/,
                            :message => 'doesn’t look like a valid address'
  validates_presence_of     :twitter_username,
                            :message => 'must be entered',
                            :if => :has_twitter_password?
  validates_presence_of     :twitter_password,
                            :message => 'must be entered',
                            :if => :has_twitter_username?
  validates_length_of       :twitter_username, :within => 1..15,
                            :if => :has_twitter_username?
  validates_length_of       :twitter_password, :within => 6..30,
                            :if => :has_twitter_password?
  validates_format_of       :twitter_username,
                            :with => /^[A-Za-z0-9_-]+$/,
                            :message => 'can only contain letters, numbers or underscores',
                            :if => :has_twitter_username?
  
  before_create :generate_feed_guid
  before_save   :encrypt_password
  
  # prevents a user from submitting a crafted form that bypasses activation
  # anything else you want your user to change should be added here.
  attr_accessible :email, :password, :password_confirmation,
                  :twitter_username, :twitter_password

  # Authenticates a user by their login name and unencrypted password.  Returns the user or nil.
  def self.authenticate(email, password)
    u = find_by_email(email) # need to get the salt
    u && u.authenticated?(password) ? u : nil
  end

  # Encrypts some data with the salt.
  def self.encrypt(password, salt)
    Digest::SHA1.hexdigest("--#{salt}--#{password}--")
  end
  
  # Encrypts the password with the user salt
  def encrypt(password)
    self.class.encrypt(password, salt)
  end

  def authenticated?(password)
    crypted_password == encrypt(password)
  end

  def name
    "#{forenames} #{surname}"
  end
  
  def remember_token?
    remember_token_expires_at && Time.now.utc < remember_token_expires_at 
  end

  # These create and unset the fields required for remembering users between browser closes
  def remember_me
    remember_me_for 2.weeks
  end

  def remember_me_for(time)
    remember_me_until time.from_now.utc
  end

  def remember_me_until(time)
    self.remember_token_expires_at = time
    self.remember_token            = encrypt("#{email}--#{remember_token_expires_at}")
    save(false)
  end

  def forget_me
    self.remember_token_expires_at = nil
    self.remember_token            = nil
    save(false)
  end
  
  def watches_updated_on
    return 'First update pending' if watches_updated_at.nil?
    "Updated on #{watches_updated_at.utc.strftime('%d %B %Y at %H:%M %Z')}"
  end
  
  def sms_configured?
    twitter_username.present? && twitter_password.present?
  end

  protected
  
  # before filter 
  def encrypt_password
    return if password.blank?
    self.salt = Digest::SHA1.hexdigest("--#{Time.now.to_s}--#{email}--") if new_record?
    self.crypted_password = encrypt(password)
  end
  
  def password_required?
    crypted_password.blank? || !password.blank?
  end
  
  private
  def generate_feed_guid
    @attributes['feed_guid'] = UUID.random_create.to_s
  end
  
  def has_twitter_password?
    twitter_password.present?
  end
  
  def has_twitter_username?
    twitter_username.present?
  end
end