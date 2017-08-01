class AddWordsWordId < ActiveRecord::Migration[5.1]
  def change
    add_column :words, :parent_id, :integer
  end
end
