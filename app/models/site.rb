class Site < ActiveRecord::Base

  belongs_to :client
  has_many :site_targets
  has_many :targets, through: :site_targets

  validates :client, presence: true   
  validates :name, presence: true 
  validates :url, presence: true 

  def new_targets
    targets.where('site_targets.contacted IS NULL')
  end

  def to_s
    name
  end

end
