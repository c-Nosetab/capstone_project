class Shift < ApplicationRecord
  has_many :position_shifts
  has_many :positions, through: :position_shifts
  has_many :employee_shifts
  has_many :employees, through: :employee_shifts
end
