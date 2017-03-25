class AddDefaultSiteofthesay2 < ActiveRecord::Migration[5.0]
  def change
  	remove_column :portfolios, :siteoftheday
  	add_column :portfolios, :siteoftheday , :boolean, :default => false
  end
end
