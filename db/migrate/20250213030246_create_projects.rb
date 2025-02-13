class CreateProjects < ActiveRecord::Migration[8.0]
  def change
    create_table :projects do |t|
      t.string :title, null: false
      t.text :description, null: false
      t.references :portfolio, null: false, foreign_key: true

      t.timestamps
    end
  end
end
