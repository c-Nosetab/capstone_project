class EmployeeShift < ApplicationRecord
  belongs_to :shifts
  belongs_to :employees
end
