class AddCountToVille < ActiveRecord::Migration[5.0]
  def change

  	add_column :villes, :like, :integer
  	change_column :villes, :like , :integer, :default => 0
  end
end
