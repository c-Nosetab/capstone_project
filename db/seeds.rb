# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


Company.create!(
                name: "Bateson's Bistro",
                phone: "586-365-9999",
                address: Faker::Address.street_address,
                address2: Faker::Address.secondary_address,
                city: Faker::Address.city,
                state: Faker::Address.state,
                zip: Faker::Address.zip_code,
                unique_code: "abcde"
                )

Position.create!(
                 position_name: "Server",
                 company_id: 1
                )

Position.create!(
                 position_name: "Manager",
                 company_id: 1
                )


Position.create!(
                 position_name: "Food Runner",
                 company_id: 1
                )


Position.create!(
                 position_name: "Bartender",
                 company_id: 1
                )

Position.create!(
                 position_name: "Chef",
                 company_id: 1
                )

Position.create!(
                 position_name: "Host",
                 company_id: 1
                )


10.times do

  first_name = Faker::Name.first_name
  last_name = Faker::Name.last_name


  Employee.create!(
                    first_name: first_name,
                    last_name: last_name,
                    email: "#{first_name}#{last_name}@gmail.com",
                    address: Faker::Address.street_address,
                    address2: Faker::Address.secondary_address,
                    city: Faker::Address.city,
                    state: Faker::Address.state,
                    zip: Faker::Address.zip_code,
                    position_id: rand(1..6),
                    phone: Faker::PhoneNumber.phone_number
    )


end