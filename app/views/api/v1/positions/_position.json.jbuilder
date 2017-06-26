json.id             position.id
json.position_name  position.position_name
json.employees      position.employees.each do |employee|
  json.id         employee.id
  json.full_name  employee.full_name
  json.position   employee.position.position_name
  json.availabilities employee.availabilities.each do |avail|
    json.id avail.id
    json.day_of_week  avail.day_of_week
    json.time_available avail.time_available
  end
end
