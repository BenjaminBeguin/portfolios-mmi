class AddStatut < ActiveRecord::Migration[5.0]
  def change
  	add_column :portfolios, :state, :string
  	add_column :portfolios, :siteoftheday, :string
  	add_column :portfolios, :count, :integer
  end
end
