# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'random_data'
require 'faker'

20.times do
  User.create!(
  email: Faker::Internet.email,
  password: Faker::Name.name
  )
end

users = User.all

15.times do
  Wiki.create!(
  title: Faker::Superhero.name,
  body: Faker::ChuckNorris.fact,
  private: false,
  user: users.sample
  )
end

puts "Seeding finished"
puts "#{User.count} users created"
puts "#{Wiki.count} wiki entries created"
