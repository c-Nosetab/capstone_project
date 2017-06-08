class Position < ApplicationRecord
  belongs_to :company

  has_many :employees
  has_many :position_shifts
  has_many :shifts, through: :position_shifts



end
