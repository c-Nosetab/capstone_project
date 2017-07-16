# # This file should contain all the record creation needed to seed the database with its default values.
# # The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
# #
# # Examples:
# #
# #   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
# #   Character.create(name: 'Luke', movie: movies.first)


company = Company.create!(
                name: "Batesons's Bistro",
                phone: "123-456-7890",
                address: Faker::Address.street_address,
                address2: Faker::Address.secondary_address,
                city: Faker::Address.city,
                state: Faker::Address.state,
                zip: Faker::Address.zip_code,
                )

Position.create!(
                 position_name: "Server",
                 company_id: company.id
                )


Position.create!(
                 position_name: "Food Runner",
                 company_id: company.id
                )


Position.create!(
                 position_name: "Bartender",
                 company_id: company.id
                )

Position.create!(
                 position_name: "Chef",
                 company_id: company.id
                )

Position.create!(
                 position_name: "Host",
                 company_id: company.id
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
                    company_id: company.id,
                    password: "alskjfdhalkds"
    )
end

days = ['monday', 'tuesday', 'wednesday', 'thursday', 'friday', 'saturday', 'sunday']
date_start = Time.utc(2015, 1, 1, 7, 0)
date_end = Time.utc(2025, 12, 25, 17, 59)

Employee.create!(
                first_name: "Test",
                last_name: 'Account',
                email: "test@gmail.com",
                address: Faker::Address.street_address,
                address2: Faker::Address.secondary_address,
                city: Faker::Address.city,
                state: Faker::Address.state,
                zip: Faker::Address.zip_code,
                position_id: 1,
                phone: Faker::PhoneNumber.phone_number,
                company_id: 1,
                password: "password",
                is_admin?: true,
                is_manager?: true
  )

Employee.create!(
                first_name: "Chris",
                last_name: 'Bateson',
                email: "cpbateson@gmail.com",
                address: Faker::Address.street_address,
                address2: Faker::Address.secondary_address,
                city: Faker::Address.city,
                state: Faker::Address.state,
                zip: Faker::Address.zip_code,
                position_id: 1,
                phone: Faker::PhoneNumber.phone_number,
                company_id: 1,
                password: "password",
                is_admin?: true,
                is_manager?: true
  )

Employee.all.each do |employee|
  weekdays = ['monday', 'tuesday', 'wednesday', 'thursday', 'friday', 'saturday', 'sunday']
    5.times do
        Availability.create!(day_of_week: weekdays.delete_at(rand(weekdays.length)),
                             time_start: date_start,
                             time_end: date_end,
                             start_date: date_start,
                             end_date: date_end,
                             employee_id: employee.id,
                             company_id: 1
                             )
    end
end


  numbers = (1..201).to_a

130.times do

    date = Date.ordinal(2017, numbers.delete_at(rand(numbers.length)))
    start = Time.utc(date.year, date.month, date.day, 8)
    end_time = Time.utc(date.year, date.month, date.day, 16)


    shift = Shift.create!(
                  time_start: start,
                  time_end: end_time,
                  date: date,
                  day_of_week: start.strftime('%A').downcase,
                  company_id: 1
                )

    pos_id = [1,2,3,4,5]

    3.times do

        position_shift = PositionShift.create!(
                              position_id: pos_id.delete_at(rand(pos_id.length)),
                              shift_id: shift.id,
                              quantity: rand(1..3),
                              company_id: 1
                            )
        emp_id = []

        Employee.where(position_id: position_shift.position.id).each {|emp| emp_id << emp.id}

        position_shift.quantity.times do

           if emp_id.length > 0
            EmployeeShift.create!(
                                  employee_id: emp_id.delete_at(rand(emp_id.length)),
                                  shift_id: shift.id,
                                  company_id: 1
                )
          end
        end

    end

end

Employee.all.each {|emp| emp.update(created_at: Time.utc(2017, rand(1..3)))}