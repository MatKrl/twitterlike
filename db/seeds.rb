# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create(email: 'admin@example.com', password: 'password', username: 'Admin', first_name: 'Mat', last_name: 'Krl')

50.times do |i|
  user = User.create(
    email: FFaker::Internet.safe_email,
    password: 'password',
    username: FFaker::Internet.user_name+"_#{i}",
    first_name: FFaker::Name.first_name,
    last_name: FFaker::Name.last_name
  )
end

1000.times do |j|
  message = Message.create(
    user: User.order("RAND()").first,
    content: FFaker::Lorem.paragraph
  )
end

3000.times do |j|
  comment = Comment.create(
    user: User.order("RAND()").first,
    message: Message.order("RAND()").first,
    content: FFaker::Lorem.paragraph
  )
end
