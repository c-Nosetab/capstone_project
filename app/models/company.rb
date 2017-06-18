class Company < ApplicationRecord
  has_many :positions
  has_many :employees
  has_many :shifts

end
