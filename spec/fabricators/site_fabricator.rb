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

# require_relative 'client_fabricator'
# But I shouldn't always need a client, and also, don't know how to do it anyway
Fabricator(:site) do  
  name { Faker::Company.name }  
  url { Faker::Internet.http_url}
  client
end
