class SiteTarget < ActiveRecord::Base

  belongs_to :target
  belongs_to :site

  scope :uncontacted, -> { where('contacted IS NULL') }
  scope :contacted,   -> { where('contacted IS NOT NULL') }

  delegate :name, to: :target, prefix: true
  # I need help understanding this line

end
