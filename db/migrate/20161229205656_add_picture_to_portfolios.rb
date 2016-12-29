class AddPictureToPortfolios < ActiveRecord::Migration[5.0]
  def change
    add_column :portfolios, :avatar, :string
  end
end
