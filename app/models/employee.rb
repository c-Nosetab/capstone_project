class Employee < ApplicationRecord
  has_secure_password
  validates :email, presence: true
  # validates :email, uniqueness: true

  has_many :employee_shifts
  has_many :shifts, through: :employee_shifts
  has_many :availabilities

  belongs_to :position, optional: true
  belongs_to :company




  def manager?
    if is_manager?
      "Manager of "
    end
  end

  def check_admin
    if is_admin?
      "checked=\"checked\""
    end
  end

  def check_manager
    if is_manager?
      "checked=\"checked\""
    end
  end

  def select_position(pos_id)
    if position_id == pos_id
      "checked=\"checked\""
    end
  end

  def find_shift_assign(shift_id)
    EmployeeShift.find_by(employee_id: id, shift_id: shift_id).id
  end

end
