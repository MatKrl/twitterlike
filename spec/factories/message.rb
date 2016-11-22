FactoryGirl.define do
  factory :message do
    content 'Test content'
    factory :user1_message do
      association :user, factory: :user1
    end
  end
end