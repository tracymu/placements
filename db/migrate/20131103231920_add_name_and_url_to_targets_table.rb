class AddNameAndUrlToTargetsTable < ActiveRecord::Migration
  def change
  	add_column :targets, :name, :string
    add_column :targets, :url, :string
  end
end
