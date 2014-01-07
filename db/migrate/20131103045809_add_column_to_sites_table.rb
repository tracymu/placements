class AddColumnToSitesTable < ActiveRecord::Migration
 
  def change
   add_column :sites, :name, :string
   add_column :sites, :url, :string
  end
 
end
