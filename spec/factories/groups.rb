FactoryGirl.define do

  factory :group do

    name { Faker::Name.name }
    created_at { Faker::Time.between(7.days.ago, Time.now, :all) }
  end

end
