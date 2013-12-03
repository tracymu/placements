class Client < ActiveRecord::Base

  has_many :sites

  validates :name, presence: true, uniqueness: true

end
