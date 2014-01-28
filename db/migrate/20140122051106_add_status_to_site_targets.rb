class AddStatusToSiteTargets < ActiveRecord::Migration
  def change
    add_column :site_targets, :status, :string
  end
end
