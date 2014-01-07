Fabricator(:target) do
  name { Faker::Company.name }
  url { Faker::Internet.http_url}
end