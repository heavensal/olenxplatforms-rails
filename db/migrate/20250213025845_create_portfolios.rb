class CreatePortfolios < ActiveRecord::Migration[8.0]
  def change
    create_table :portfolios do |t|
      t.string :company_name
      t.text :description
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
