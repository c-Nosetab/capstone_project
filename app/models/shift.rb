class Shift < ApplicationRecord
  has_many :position_shifts
  has_many :positions, through: :position_shifts
  has_many :employee_shifts
  has_many :employees, through: :employee_shifts
  belongs_to :company

  validates :company_id, presence: true

  enum day_of_week: { monday: 0, tuesday: 1, wednesday: 2, thursday: 3, friday: 4, saturday: 5, sunday: 6}


  def check_month
    if self == Time.now.month
      "checked=\"checked\""
    end
  end

  def assigned_ids
    ids = []

    employees.each do |employee|
      ids << employee.id
    end

    ids
  end

  def position_ids
    pos_ids = []

    positions.each do |position|
      pos_ids << position.id
    end

    pos_ids
  end


end
