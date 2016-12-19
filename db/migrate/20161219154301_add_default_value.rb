class AddDefaultValue < ActiveRecord::Migration[5.0]
  def change
  	change_column :portfolios, :like , :integer, :default => 0
  	change_column :portfolios, :visite , :integer, :default => 0
  	change_column :users, :visites , :integer, :default => 0

  	rename_column :users, :visites, :visite

  end
end
