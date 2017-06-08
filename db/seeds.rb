# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


10.times do

  first_name = Faker::Name.first_name
  last_name = Faker::Name.last_name
  positions = ["Manager", "Server", "Food Runner", "Bartender", "Chef", "Host"].sample

  Employee.create!(
                    first_name: first_name,
                    last_name: last_name,
                    email: "#{first_name}#{last_name}@gmail.com",
                    address: Faker::Address.street_address,
                    address2: Faker::Address.secondary_address,
                    city: Faker::Address.city,
                    state: Faker::Address.state,
                    zip: Faker::Address.zip_code
    )


end