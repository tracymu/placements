# == Schema Information
#
# Table name: targets
#
#  id         :integer          not null, primary key
#  created_at :datetime
#  updated_at :datetime
#  name       :string(255)
#  url        :string(255)
#

class Target < ActiveRecord::Base

  has_many :site_targets
  has_many :sites, through: :site_targets

end
