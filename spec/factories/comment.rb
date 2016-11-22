FactoryGirl.define do
  factory :comment do
    message
    content 'Test content'
    factory :user1_comment do
      association :user, factory: :user1
    end
  end
end
