class WordRefactor < ActiveRecord::Migration
  def up
    create_table :pos do |t|
      t.string :name
      t.string :tamil_name
      t.timestamps
    end

    add_index :pos, :name

    remove_column :words, :parts_of_speech
    remove_column :words, :pronunciation
    remove_column :words, :description

    remove_index :words, :name

    add_index :words, :name

    create_table :word_details do |t|
      t.references :word
      t.references :pos
      t.string :parts_of_speech
      t.string :pronunciation
      t.text :description
    end

    add_index :word_details, [:word_id, :pos_id], :unique => true
  end

  def down

    remove_index :pos, :name

    drop_table :pos

    add_column :words, :parts_of_speech, :string
    add_column :words, :pronunciation, :string
    add_column :words, :description, :text

    remove_index :words, :name

    add_index :words, :name, :unique => true

    remove_index :word_details, [:word_id, :pos_id]

    drop_table :word_details

  end
end
