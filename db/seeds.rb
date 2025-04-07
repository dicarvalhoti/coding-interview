# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

puts "Starting to seed the database..."
5.times do
  company = Company.create(name: Faker::Company.name)
  5.times do |index|
    user = User.create(display_name: Faker::Name.name, email: Faker::Internet.email, username: "user_#{company.id}_#{index+1}", company_id: company.id)
    100.times do
      Tweet.create(body: Faker::GreekPhilosophers.quote, user_id: user.id)
    end
  end
end
puts "Seeding completed!"