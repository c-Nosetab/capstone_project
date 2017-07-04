json.id company.id
json.name company.name
json.positions company.positions.each do |position|
  json.id position.id
  json.name position.position_name
  json.employed position.employees.count
  quantity = position.position_shifts.sum(:quantity)
  json.stats {
    json.all_time_shifts quantity
    count = 0
    Employee.where(position_id: position.id).each do |employee|
      count += employee.employee_shifts.count
    end
    json.all_time_shift_quantity count
    if quantity > 0
      json.average_quantity_per_shift (count / quantity).to_f
    end
  }


end
json.shifts (5.year.ago.year..Time.now.year).each do |year|
  if company.shifts.where(:date => Time.utc(year)...Time.utc(year+1)).count > 0
    json.year year
    json.total_year_shifts company.shifts.where(:date => Time.utc(year)...Time.utc(year+1)).count
      count = 0
    company.shifts.where(:date => Time.utc(year)...Time.utc(year+1)).each do |shift|
      count += shift.position_shifts.sum(:quantity)
    end
    json.total_employee_shifts count
    json.months (1..12).each do |month|
      time = Time.utc(year, month)
      if time < Time.now
          json.month month
        if month < 12
          json.total_month_shifts company.shifts.where(:date => time...Time.utc(year, month + 1)).count
          json.shifts company.shifts.where(:date => time..Time.utc(year, month + 1)).each do |shift|
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
          json.shifts company.shifts.where(:date => time..Time.utc(year +1 , 1)).each do |shift|
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
        end
      end
    end
  end
end


# json.shifts company.shifts.each do |shift|
  # json.id shift.id
  # json.day shift.day_of_week
  # json.date shift.date
  # json.start_time shift.time_start.strftime('%I:%M')
  # json.end_time shift.time_end.strftime('%k:%M')
  # json.hour_duration shift.find_duration
  # json.total_quantity shift.position_shifts.sum(:quantity)



  # json.positions  shift.position_shifts.each do |pos|
  #   json.name Position.find(pos.position_id).position_name
  #   json.quantity pos.quantity
  # end

# end