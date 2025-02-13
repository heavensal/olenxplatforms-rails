class CreateIdeas < ActiveRecord::Migration[8.0]
  def change
    create_table :ideas do |t|
      t.string :title, null: false
      t.text :description, null: false
      t.references :portfolio, null: false, foreign_key: true

      t.timestamps
    end
  end
end
