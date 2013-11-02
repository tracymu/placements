class SiteTarget < ActiveRecord::Base

  belongs_to :target
  belongs_to :site

end
