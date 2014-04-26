class AddUniqueIndexToPos < ActiveRecord::Migration
  def up
    remove_index :pos, :name
    add_index :pos, :name, :unique => true
  end

  def down
    remove_index :pos, :name
    add_index :pos, :name
  end
end
