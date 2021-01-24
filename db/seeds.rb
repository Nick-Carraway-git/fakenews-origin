# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Cateories
chategories = Category.create([ { name: 'スポーツ' },
                                { name: '政治' },
                                { name: '科学' },
                                { name: '経済' },
                                { name: 'エンタメ' },
                                { name: '犯罪' },
                                { name: '医療' } ])

# User
User.create!(name: 'Guest', username: 'GuestChan', email: 'guest_user@example.com',
                introduce: '私はゲストちゃんです。私は削除/編集できません。') do |user|
                  user.password = SecureRandom.urlsafe_base64
                end

# other Users
30.times do |n|
  name  = "BotMan Type-#{n+1}"
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  introduce = "Hi! I'm BotMan Type-#{n+1}"
  User.create!(name: name,
               email: email,
               password: password,
               introduce: introduce)
end

# Relationships
users = User.all
user  = users.first
following = users[2..30]
followers = users[3..25]
following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) }

# Minimails
senders = users[2..30]
recievers = users[3..25]
recievers.each { |reciever| user.send_minimails.create!(reciever_id: reciever.id,
                                                        title: "Sended Mail #{reciever.id}",
                                                        content: "Hello BotMan Type-#{reciever.id}") }
senders.each { |sender| user.recieve_minimails.create!(sender_id: sender.id,
                                                        title: "Recieved Mail #{sender.id}",
                                                        content: "Hello Guest Chan! #{sender.id}") }
