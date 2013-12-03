class Target < ActiveRecord::Base

  has_many :site_targets
  has_many :sites, through: :site_targets

  validates :name, presence: true, uniqueness: true
  validates :url, presence: true, uniqueness: true

end
