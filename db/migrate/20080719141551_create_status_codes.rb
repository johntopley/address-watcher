class CreateStatusCodes < ActiveRecord::Migration
  def self.up
    create_table :status_codes do |t|
      t.integer :status_type_id
      t.string :code
      t.string :description
    end
  end

  def self.down
    drop_table :status_codes
  end
end