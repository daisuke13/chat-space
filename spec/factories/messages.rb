FactoryGirl.define do

  factory :message do
    association :user, factory: :user
    association :group, factory: :group

    body { Faker::Lorem.sentence }
    created_at { Faker::Time.between(7.days.ago, Time.now, :all) }
  end

end
