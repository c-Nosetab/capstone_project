# # This file should contain all the record creation needed to seed the database with its default values.
# # The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
# #
# # Examples:
# #
# #   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
# #   Character.create(name: 'Luke', movie: movies.first)


# company = Company.create!(
#                 name: "Batesons's Bistro",
#                 phone: "123-456-7890",
#                 address: Faker::Address.street_address,
#                 address2: Faker::Address.secondary_address,
#                 city: Faker::Address.city,
#                 state: Faker::Address.state,
#                 zip: Faker::Address.zip_code,
#                 )

# Position.create!(
#                  position_name: "Server",
#                  company_id: company.id
#                 )


# Position.create!(
#                  position_name: "Food Runner",
#                  company_id: company.id
#                 )


# Position.create!(
#                  position_name: "Bartender",
#                  company_id: company.id
#                 )

# Position.create!(
#                  position_name: "Chef",
#                  company_id: company.id
#                 )

# Position.create!(
#                  position_name: "Host",
#                  company_id: company.id
#                 )

# array = []

# Position.all.each {|pos| array << pos.id}

# 30.times do

#   first_name = Faker::Name.first_name
#   last_name = Faker::Name.last_name


#   Employee.create!(
#                     first_name: first_name,
#                     last_name: last_name,
#                     email: "#{first_name}#{last_name}@gmail.com",
#                     address: Faker::Address.street_address,
#                     address2: Faker::Address.secondary_address,
#                     city: Faker::Address.city,
#                     state: Faker::Address.state,
#                     zip: Faker::Address.zip_code,
#                     position_id: array.sample,
#                     phone: Faker::PhoneNumber.phone_number,
#                     company_id: company.id,
#                     password: "password"
#     )
# end

days = ['monday', 'tuesday', 'wednesday', 'thursday', 'friday', 'saturday', 'sunday']
date_start = Time.utc(2015, 1, 1, 7, 0)
date_end = Time.utc(2025, 12, 25, 17, 59)


Employee.all.each do |employee|
    5.times do
        Availability.create!(day_of_week: days.sample,
                             time_start: date_start,
                             time_end: date_end,
                             start_date: date_start,
                             end_date: date_end,
                             employee_id: employee.id,
                             company_id: 1
                             )
    end
end

# Employee.create(
#                 first_name: "Chris",
#                 last_name: 'Bateson',
#                 email: "cpbateson@gmail.com",
#                 address: Faker::Address.street_address,
#                 address2: Faker::Address.secondary_address,
#                 city: Faker::Address.city,
#                 state: Faker::Address.state,
#                 zip: Faker::Address.zip_code,
#                 position_id: 1,
#                 phone: Faker::PhoneNumber.phone_number,
#                 company_id: 1,
#                 password: "password",
#                 is_admin?: true,
#                 is_manager?: true
#   )