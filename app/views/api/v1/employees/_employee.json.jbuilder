json.id         position.id
json.name       position.position_name
json.managers    position.employees.where(is_manager?: true).each do |manager|
  json.id             manager.id
  json.last_name      manager.last_name
  json.full_name      manager.full_name
  json.email          manager.email
  json.phone          manager.phone
  json.street_address manager.full_address_1
  json.city           manager.city
  json.state          manager.state
  json.zip            manager.zip
  json.manager        true
  json.position       manager.position.position_name
end
json.employees  position.employees.order(:last_name).each do |employee|
  if !employee.is_manager?
    json.id         employee.id
    json.last_name  employee.last_name
    json.full_name  employee.full_name
    json.email      employee.email
    json.phone      employee.phone
    json.street_address    employee.full_address_1
    json.city       employee.city
    json.state      employee.state
    json.zip        employee.zip
    json.position   employee.position.position_name
  end
end
