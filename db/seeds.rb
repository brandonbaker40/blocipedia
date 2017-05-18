
# Create Users
15.times do
   User.create!(
   email:    Faker::Internet.free_email,
   password: Faker::Internet.password(8),
   role: Faker::Number.between(0, 2)
   )
 end
 users = User.all

 50.times do
   post = Wiki.create!(

     title: Faker::StarWars.character,
     body: Faker::StarWars.quote,
     private: Faker::Boolean.boolean,
     user_id: Faker::Number.between(1, User.count)
   )
 end
 wikis = Wiki.all

 puts "Seed finished"
 puts "#{User.count} users created"
 puts "#{Wiki.count} wikis created"
