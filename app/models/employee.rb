class Employee < ApplicationRecord
  has_many :employees_shifts
  has_many :shifts, through: :employees_shifts
  has_many :availabilities

  belongs_to :position
end
