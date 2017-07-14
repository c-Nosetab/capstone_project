json.id @company.id
json.name @company.name
json.total_lifetime_shifts @company.shifts.count

json.total_employee_shift_quantity @position_shifts.sum{|shift| shift.quantity}
json.positions @positions.each do |position|
  json.id position.id
    json.name position.position_name
    json.employed position.employees.count
    quantity = position.position_shifts.count
    json.stats {
      json.all_time_shifts quantity
      if quantity > 0
        count = 0
        @position_shifts.select{|pos| pos.position_id == position.id}.each do |position_shift|
          count += position_shift.quantity
        end
        json.all_time_shift_quantity count
          json.average_quantity_per_shift (count.to_f / quantity.to_f).round(2)
      end
    }
  end


  json.shifts (1.year.ago.year..Time.now.year).each do |year|
    if @shifts.select{|shift| shift.date.between?(Time.utc(year), (Time.utc(year+1)) - 1.minute) }.count > 0
      year_shifts = @shifts.select{|shift| shift.date.between?(Time.utc(year), Time.utc((year+1))) }

      json.year year
      json.total_year_shifts year_shifts.count
        count = 0
      year_shifts.each do |shift|
        @position_shifts.select{|pos| pos.shift_id == shift.id}.each do |shift_pos|
          count += shift_pos.quantity
        end
      end
      json.year_employee_shift_quantity count
      json.months (1..12).each do |month|
        if Time.now > Time.utc(year, month)
          time = Time.utc(year, month)
          json.month time.strftime('%B')
          if month < 12
            month_shifts = year_shifts.select{|shift| shift.date.between?(Time.utc(year, month) , (Time.utc(year, month + 1) - 1.second) ) }
            json.total_month_shifts month_shifts.count
          end
        end
      end

    end

  end

  json.employees @employees.each do |employee|
    json.id employee.id
    json.name employee.full_name
    json.position employee.position.position_name

    if employee.shifts.count > 0
      json.total_shifts_scheduled employee.shifts.count
      json.average_shifts_per_month employee.find_average_monthly_shifts
    end
  end


