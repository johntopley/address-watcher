class Watch < ActiveRecord::Base
  belongs_to :user
  
  validates_presence_of   :name,    :message => 'is required'
  validates_presence_of   :address, :message => 'is required'
  validates_length_of     :name, :in => 2..50,      :if => :has_name?
  validates_length_of     :address, :in => 10..500, :if => :has_address?
  validates_uniqueness_of :name, :scope => :user_id,
                          :message => 'must be unique'
  validates_uniqueness_of :address, :scope => :user_id,
                          :message => 'must be unique'
  validates_format_of     :address,
                          :with => /^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?$/ix,
                          :message => 'doesn’t look like a valid URL (http or https only)',
                          :if => :has_address?
  validates_format_of     :name,
                          :with => /^[A-Za-z0-9_\s-]+$/,
                          :message => 'can only contain letters, numbers, underscores, hyphens or spaces',
                          :if => :has_name?
  
  def self.find_by_permalink(user, permalink)
    find_by_user_id_and_name(user, permalink.gsub(/-/, ' '))
  end
  
  def self.find_all(user, page)
    paginate_by_user_id(user, :per_page => APP_CONFIG['watches_per_page'],
      :page => page, :order => 'name ASC')
  end
  
  def actual
    self[:actual].blank? ? 'N/A' : self[:actual]
  end
  
  def permalink
    "#{created_at.year}-#{created_at.strftime('%m')}-#{created_at.strftime('%d')}:#{to_param}"
  end
  
  def to_param
    name.downcase.gsub(/ /, '-')
  end
    
  private
  def has_address?
    address.present?
  end
  
  def has_name?
    name.present?
  end
end