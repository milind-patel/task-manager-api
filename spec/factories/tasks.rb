FactoryBot.define do
  factory :task do
    title { Faker::Lorem.sentence }
    description { Faker::Lorem.paragraph }
    status { :pending }
    priority { :medium }
    due_date { 1.week.from_now }
    association :user
  end
end
