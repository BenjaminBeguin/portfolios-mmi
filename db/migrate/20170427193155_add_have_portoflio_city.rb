class AddHavePortoflioCity < ActiveRecord::Migration[5.0]
  def change
    add_column :villes, :have_portfolio , :boolean, :default => false
  end
end
