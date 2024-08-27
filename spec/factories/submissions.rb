FactoryBot.define do
  factory :submission do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    mobile_phone { Faker::PhoneNumber.cell_phone }
    resume { "resume_#{Faker::Number.number(digits: 10)}.pdf" }
    association :job
  end
end
