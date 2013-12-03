# == Schema Information
#
# Table name: sites
#
#  id         :integer          not null, primary key
#  client_id  :integer
#  created_at :datetime
#  updated_at :datetime
#  name       :string(255)
#  url        :string(255)
#

class Site < ActiveRecord::Base

  belongs_to :client
  has_many :site_targets
  has_many :targets, through: :site_targets

  validates :client, presence: true   
  validates :name, presence: true 
  validates :url, presence: true 

  def to_s
    name
  end

end
