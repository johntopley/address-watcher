class AddIndexesToWatches < ActiveRecord::Migration
  def self.up
    add_index :watches, [:name]
  end

  def self.down
    remove_index :watches, [:name]
  end
end