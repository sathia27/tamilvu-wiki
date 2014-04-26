class CreateWords < ActiveRecord::Migration
  def change
    create_table :words do |t|
      t.string :word
      t.string :pronunciation
      t.string :parts_of_speech
      t.string :language, :default => 'tamil'
      t.string :description, :limit => 1000
      t.string
      t.boolean :existing_in_wiki
      t.boolean :uploaded_to_wiki
      t.timestamps

    end
    add_index :words, :word, :unique => true
    add_index :words, :existing_in_wiki
    add_index :words, :uploaded_to_wiki
  end
end
