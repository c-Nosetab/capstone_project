class EmployeeShift < ApplicationRecord
  belongs_to :shift
  belongs_to :employee
end
