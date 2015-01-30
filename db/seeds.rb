User.create!(name:  "Example User",
             email: "example@railstutorial.org",
             password:              "foobar",
             password_confirmation: "foobar",
             admin:                 true,
             activated: true,
             activated_at: Time.zone.now)

User.create!(name:  "Mr. Chris Willms",
             email: "example-1@railstutorial.org",
             password:              "password",
             password_confirmation: "password",
             admin:                 false,
             activated: true,
             activated_at: Time.zone.now)


98.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+2}@railstutorial.org"
  password = "password"
  User.create!(name:  name,
               email: email,
               password:              password,
               password_confirmation: password)
end

User.create!(name:  "Hung Son",
             email: "hungson91cb@gmail.com",
             password:              "123456",
             password_confirmation: "123456",
             admin:                 false,
             activated: true,
             activated_at: Time.zone.now)

users = User.order(:created_at).take(6)
50.times do
  content = Faker::Lorem.sentence(5)
  title = Faker::Lorem.sentence(10)
  users.each { |user| user.entries.create!(title: title, content: content) }
end

# Following relationships
users = User.all
user  = users.first
following = users[2..50]
followers = users[3..40]
following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) }

