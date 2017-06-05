class CreateProjects < ActiveRecord::Migration[5.1]
  def change
    create_table :projects do |t|
      t.integer :user_id, null: false
      t.string :name, null: false
      t.integer :default_language_id, null: false
      t.timestamps
    end
    add_index :projects, :user_id
    add_foreign_key :projects, :users
  end
end
