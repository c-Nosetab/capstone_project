# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


Company.create!(
                name: "Devine Deli",
                phone: "123-456-7890",
                address: Faker::Address.street_address,
                address2: Faker::Address.secondary_address,
                city: Faker::Address.city,
                state: Faker::Address.state,
                zip: Faker::Address.zip_code,
                unique_code: "12345"
                )

Position.create!(
                 position_name: "Server",
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

array = []

Position.all.each {|pos| array << pos.id}

30.times do

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
                    position_id: array.sample,
                    phone: Faker::PhoneNumber.phone_number,
                    company_id: 2,
                    password: "password"
    )


end