class AddContactedToSiteTargets < ActiveRecord::Migration
  def change
  	add_column :site_targets, :contacted, :datetime
  end
end
