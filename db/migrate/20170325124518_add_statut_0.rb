class AddStatut0 < ActiveRecord::Migration[5.0]
  def change
  	change_column :portfolios, :count , :integer, :default => 0
  end
end
