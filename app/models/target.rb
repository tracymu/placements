class Target < ActiveRecord::Base

  has_many :site_targets
  has_many :sites, through: :site_targets

end
