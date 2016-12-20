class AddPublishedAndAdmin < ActiveRecord::Migration[5.0]
  def change

  	add_column :portfolios, :published, :boolean,  :default => true
  	add_column :users, :admin, :boolean,  :default => false
 
  end
end
