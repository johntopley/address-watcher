class AddIndexesToWatches < ActiveRecord::Migration
  def self.up
    add_index :watches, [:name, :address]
  end

  def self.down
    remove_index :watches, [:name, :address]
  end
end