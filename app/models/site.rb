class Site < ActiveRecord::Base

  belongs_to :client
  has_many :site_targets
  has_many :targets, through: :site_targets

  validates :client, presence: true 

end
