class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table "users", :force => true do |t|
      t.column :forenames,                 :string, :limit => 100
      t.column :surname,                   :string, :limit => 100
      t.column :email,                     :string, :limit => 100
      t.column :crypted_password,          :string, :limit => 40
      t.column :salt,                      :string, :limit => 40
      t.column :created_at,                :datetime
      t.column :updated_at,                :datetime
      t.column :remember_token,            :string, :limit => 40
      t.column :remember_token_expires_at, :datetime
      t.column :feed_guid,                 :string
      t.column :watches_updated_at,        :datetime
      t.column :twitter_username,          :string, :limit => 15
      t.column :twitter_password,          :string, :limit => 30
    end
    add_index :users, :email, :unique => true
  end

  def self.down
    drop_table "users"
  end
end