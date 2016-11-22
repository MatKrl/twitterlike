FactoryGirl.define do
  factory :user do
    password "password"
    password_confirmation "password"
    
    factory :user1 do
      email 'user1@example.com'
      username 'test_user_1'
      first_name 'Andy'
      last_name 'Black'
    end

    factory :user2 do
      email 'user2@example.com'
      username 'test_user_2'
      first_name 'John'
      last_name 'Doe'
    end

    factory :user3 do
      email 'user3@example.com'
      username 'test_user_3'
      first_name 'Fred'
      last_name 'Jones'
    end
  end
end