class ChangeCollumnNameAvatar < ActiveRecord::Migration[5.0]
  def change
  	rename_column :portfolios, :avatar, :picture
  end
end
