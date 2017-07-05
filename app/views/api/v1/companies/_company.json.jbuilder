json.id company.id
json.name company.name
json.total_lifetime_shifts company.shifts.count

json.total_employee_shift_quantity PositionShift.where(company_id: company.id).sum(:quantity)
json.positions company.positions.each do |position|
  json.id position.id
  json.name position.position_name
  json.employed position.employees.count
  quantity = position.position_shifts.count
  json.stats {
    json.all_time_shifts quantity
    if quantity > 0
      count = 0
      PositionShift.where(position_id: position.id).each do |position_shift|
        count += position_shift.quantity
      end
      json.all_time_shift_quantity count
        json.average_quantity_per_shift (count.to_f / quantity.to_f).round(2)
    end
  }


end
json.shifts (1.year.ago.year..Time.now.year).each do |year|
  if company.shifts.where(:date => Time.utc(year)...Time.utc(year+1)).count > 0
     year_shifts = company.shifts.where(:date => Time.utc(year)...Time.utc(year+1))

    json.year year
    json.total_year_shifts year_shifts.count
      count = 0
    year_shifts.each do |shift|
      count += shift.position_shifts.sum(:quantity)
    end
    json.year_employee_shift_quantity count
    json.months (1..12).each do |month|
      if Time.now > Time.utc(year, month)
        time = Time.utc(year, month)
            month_label = "January" if month == 1
            month_label = "February" if month == 2
            month_label = "March" if month == 3
            month_label = "April" if month == 4
            month_label = "May" if month == 5
            month_label = "June" if month == 6
            month_label = "July" if month == 7
            month_label = "August" if month == 8
            month_label = "September" if month == 9
            month_label = "October" if month == 10
            month_label = "November" if month == 11
            month_label = "December" if month == 12

            json.month month_label
          if month < 12
            month_shifts = year_shifts.where(:date => time...Time.utc(year, month + 1))

            json.total_month_shifts month_shifts.count
            count = 0
             month_shifts.each {|shift| count += shift.position_shifts.sum(:quantity)}
             json.month_employees_scheduled count


            json.shifts month_shifts.each do |shift|
              json.id shift.id
              json.day shift.day_of_week
              json.date shift.date
              json.start_time shift.time_start.strftime('%I:%M')
              json.end_time shift.time_end.strftime('%k:%M')
              json.hour_duration shift.find_duration
              json.total_quantity shift.position_shifts.sum(:quantity)
              json.positions  shift.position_shifts.each do |pos|
                json.name Position.find(pos.position_id).position_name
                json.quantity pos.quantity
              end
            end
          else
            month_shifts = year_shifts.where(:date => time..Time.utc(year +1 , 1))
            json.total_month_shifts month_shifts.count
            count = 0
            month_shifts.each {|shift| count += shift.position_shifts.sum(:quantity)}
            json.month_total_scheduled count


            json.shifts month_shifts.each do |shift|
              json.id shift.id
              json.total_quantity shift.position_shifts.sum(:quantity)
              json.day shift.day_of_week
              json.date shift.date
              json.start_time shift.time_start.strftime('%I:%M')
              json.end_time shift.time_end.strftime('%k:%M')
              json.hour_duration shift.find_duration
                count = 0
              json.positions  shift.position_shifts.each do |pos|
                json.name Position.find(pos.position_id).position_name
                json.quantity pos.quantity
              end
            end
          end
        end
      end
    end
  end

  all_shifts = company.shifts
  employees = company.employees


  json.employees employees.each do |employee|
    json.id employee.id
    json.name employee.full_name
    json.position employee.position.position_name


    shifts_worked = employee.employee_shifts
    if shifts_worked.count > 0
      json.total_shifts_scheduled shifts_worked.count
      json.average_shifts_per_month employee.find_average_monthly_shifts
    end
  end

