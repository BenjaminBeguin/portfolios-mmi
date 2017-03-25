class AddDefaultSiteofthesay < ActiveRecord::Migration[5.0]
  def change
  	remove_column :portfolios, :siteoftheday
  	add_column :portfolios, :siteoftheday , :boolean, :default => true
  end
end
