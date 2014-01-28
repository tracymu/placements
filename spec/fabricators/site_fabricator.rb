Fabricator(:site) do  
  name { Faker::Company.name }  
  url { Faker::Internet.http_url}
  client
end

