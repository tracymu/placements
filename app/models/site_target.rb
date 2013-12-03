# == Schema Information
#
# Table name: site_targets
#
#  id         :integer          not null, primary key
#  site_id    :integer
#  target_id  :integer
#  created_at :datetime
#  updated_at :datetime
#

class SiteTarget < ActiveRecord::Base

  belongs_to :target
  belongs_to :site

end
