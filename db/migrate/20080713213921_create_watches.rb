class CreateWatches < ActiveRecord::Migration
  def self.up
    create_table :watches do |t|
      t.integer :user_id,    :limit => 11,  :null => false
      t.string  :name,       :limit => 50,  :null => false
      t.string  :address,    :limit => 500, :null => false
      t.string  :expected,   :null => false
      t.string  :actual
      t.boolean :email,      :default => false, :null => false
      t.boolean :sms,        :default => false, :null => false
      t.boolean :alert_sent, :default => false, :null => false
      t.timestamps
    end
  end

  def self.down
    drop_table :watches
  end
end