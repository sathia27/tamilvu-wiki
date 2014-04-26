class AddTamilVuPageNumberToWord < ActiveRecord::Migration
  def change
    add_column :words, :tamil_vu_page_no, :integer
  end
end
