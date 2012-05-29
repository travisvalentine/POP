Fabricate(:profile) do
  bio                 { "test" }
  birthday            {  }
  first_name          { Faker::Name.first_name }
  last_name           { Faker::Name.last_name }
  job_title           { Faker::Lorem.words(3).join(" ") }
  party_affiliation   { "Test" }
  twitter             { "test" }
end