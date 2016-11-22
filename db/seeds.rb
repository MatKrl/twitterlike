# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#

def disp_progres
  print '.'
end

def random_user(without_id=nil)
  if without_id
    User.where.not(id: without_id).order("RAND()").first
  else
    User.order("RAND()").first
  end
end

puts "\n\n### Seeds import - start #{'#'*54}\n"
start_time = Time.now

User.create(email: 'admin@example.com', password: 'password', username: 'Admin', first_name: 'Mat', last_name: 'Krl')

puts "\nCreating users:"
20.times do |i|
  user = User.create(
    email: FFaker::Internet.safe_email,
    password: 'password',
    username: FFaker::Internet.user_name+"_#{i}",
    first_name: FFaker::Name.first_name,
    last_name: FFaker::Name.last_name
  )
  disp_progres
end

puts "\nCreating messages:"
100.times do |i|
  message = Message.create(
    user: random_user,
    content: FFaker::Lorem.paragraph+"_#{i}"
  )
  disp_progres
end

puts "\nCreating comments:"
100.times do |i|
  comment = Comment.create(
    user: random_user,
    message: Message.order("RAND()").first,
    content: FFaker::Lorem.paragraph+"_#{i}"
  )
  disp_progres
end

puts "\nCreating friendships:"
User.all.each do |user|
  rand(3).times do |i|
    user.friendships.create(
      friend: random_user(user.id),
      status: 'inviting'
    )
    disp_progres
  end
end

puts "\nCreating blockades:"
User.all.each do |user|
  rand(2).times do |i|
    user.blocked_users << random_user(user.id)
    disp_progres
  end
end

puts "\n\n### Seeds import - finished in #{(Time.now-start_time).round(2)} sec #{'#'*38}\n\n"
