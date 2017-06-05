class CreateLanguages < ActiveRecord::Migration[5.1]
  def change
    create_table :languages do |t|
      t.string :name, null: false
      t.string :description
      t.timestamps
    end
  end
end
