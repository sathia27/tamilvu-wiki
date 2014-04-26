class CreateWords < ActiveRecord::Migration
  def change
    create_table :words do |t|
      t.string :name
      t.string :pronunciation
      t.string :parts_of_speech
      t.string :language, :default => 'tamil'
      t.text :description
      t.boolean :existing_in_wiki, :default => false
      t.boolean :uploaded_to_wiki, :default => false
      t.timestamps

    end
    add_index :words, :name, :unique => true
    add_index :words, :existing_in_wiki
    add_index :words, :uploaded_to_wiki
  end
end
