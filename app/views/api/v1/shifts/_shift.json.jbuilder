json.id shift.id
json.date         shift.date.strftime('%B %d')
json.day_of_week  shift.day_of_week.capitalize
json.time         shift.time_of_shift
json.positions    shift.company.positions.each do |position|
  json.id             position.id
  json.position_name  position.position_name
  if position.position_shifts.find_by(shift_id: shift.id, position_id: position.id)
    json.quantity     position.position_shifts.find_by(shift_id: shift.id, position_id: position.id).quantity
    json.assigned_employees shift.employee_shifts.each do |employee_shift|
      if employee_shift.employee.position_id == position.id
        json.id         employee_shift.employee.id
        json.full_name  employee_shift.employee.full_name
        json.position   employee_shift.employee.position.position_name
      end
    end
        end
    json.unassigned_employees      position.employees.each do |employee|
      employee.availabilities.where(day_of_week: shift.day_of_week).each do |avail|
        if avail.time_start < shift.time_start && avail.time_end > shift.time_end && avail.start_date <= shift.date && avail.end_date >= shift.date && !employee.employee_shifts.find_by(employee_id: employee.id, shift_id: shift.id)
          json.id         employee.id
          json.full_name  employee.full_name
          json.position   employee.position.position_name
      end
    end
  end
end

