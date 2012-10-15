FactoryGirl.define do
  factory :problem do
		body 			Faker::Lorem::paragraph(sentence_count=2)
		solution
	end
end