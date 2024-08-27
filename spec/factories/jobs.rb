FactoryBot.define do
	factory :job do
		title { Faker::Job.title }
		description { Faker::Lorem.paragraph }
		start_date { Faker::Date.backward(days: 14) }
		end_date { Faker::Date.forward(days: 30) }
    status { :active }
		skills { Faker::Job.key_skill }
		association :recruiter
	end
end
