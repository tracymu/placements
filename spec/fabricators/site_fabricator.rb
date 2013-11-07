# require_relative 'client_fabricator'
# But I shouldn't always need a client, and also, don't know how to do it anyway
Fabricator(:site) do  
  name { Faker::Company.name }  
  url { Faker::Internet.http_url}
end
