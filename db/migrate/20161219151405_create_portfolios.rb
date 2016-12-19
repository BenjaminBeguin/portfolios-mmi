class CreatePortfolios < ActiveRecord::Migration[5.0]
  def change
    create_table :portfolios do |t|
      t.string :url
      t.integer :visite
      t.integer :like
      t.integer :user_id

      t.timestamps
    end
  end
end
