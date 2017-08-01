class CreateProjectLanguages < ActiveRecord::Migration[5.1]
  def change
    create_table :project_languages do |t|
      t.integer :project_id, null: false
      t.integer :language_id, null: false
      t.timestamps
    end
  end
end
