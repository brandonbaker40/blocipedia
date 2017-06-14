
# Create Standard Users
5.times do
   User.create!(
   email:    Faker::Internet.free_email,
   password: Faker::Internet.password(8),
   role: 0
   )
 end
 #users = User.all


# Create Premium and Admin Users
 10.times do
    User.create!(
    email:    Faker::Internet.free_email,
    password: Faker::Internet.password(8),
    role: Faker::Number.between(1, 2)
    )
  end


 #Create wikis by standard users
 20.times do
   post = Wiki.create!(

     title: Faker::StarWars.character,
     body: Faker::StarWars.quote,
     private: false, #can't be true because Standard users can't have private wikis
     user_id: Faker::Number.between(1, 5)
   )
 end
 #wikis = Wiki.all

 #Create wikis by premium and admin users
 30.times do
   post = Wiki.create!(

     title: Faker::StarWars.character,
     body: Faker::StarWars.quote,
     private: Faker::Boolean.boolean,
     user_id: Faker::Number.between(6, User.count)
   )
 end

 puts "Seed finished"
 puts "#{User.count} users created"
 puts "#{Wiki.count} wikis created"
