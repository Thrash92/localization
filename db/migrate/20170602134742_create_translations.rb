class CreateTranslations < ActiveRecord::Migration[5.1]
  def change
    create_table :translations do |t|
      t.integer :language_id, null: false
      t.integer :word_id, null: false
      t.text :text
      t.timestamps
    end
  end
end
