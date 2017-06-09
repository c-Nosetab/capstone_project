class Employee < ApplicationRecord
  has_many :employees_shifts
  has_many :shifts, through: :employees_shifts
  has_many :availabilities

  belongs_to :position



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

end
