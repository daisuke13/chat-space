FactoryGirl.define do

  factory :user do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    password { Faker::Internet.password(8) }
    password_confirmation password
    created_at { Faker::Time.between(7.days.ago, Time.now, :all) }
  end
end
