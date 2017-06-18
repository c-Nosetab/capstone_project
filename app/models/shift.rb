class Shift < ApplicationRecord
  has_many :position_shifts
  has_many :positions, through: :position_shifts
  has_many :employee_shifts
  has_many :employees, through: :employee_shifts
  belongs_to :company

  validates :company_id, presence: true

  enum day_of_week: { monday: 0, tuesday: 1, wednesday: 2, thursday: 3, friday: 4, saturday: 5, sunday: 6}

  def list_days
    days = "<select>"

    (1..31).each do |num|
      days += "<option>#{num}</option>"
    end

    days += "</select>"

    puts days
  end

  def check_month
    if self == Time.now.month
      "checked=\"checked\""
    end
  end


end
