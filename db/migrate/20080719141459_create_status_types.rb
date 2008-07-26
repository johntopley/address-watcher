class CreateStatusTypes < ActiveRecord::Migration
  def self.up
    create_table :status_types do |t|
      t.string :name
    end
  end

  def self.down
    drop_table :status_types
  end
end