class Employee < ApplicationRecord
  has_secure_password
  validates :email, presence: true
  validates :email, uniqueness: true

  has_many :employee_shifts
  has_many :shifts, through: :employee_shifts
  has_many :availabilities

  belongs_to :position, optional: true
  belongs_to :company


  # This method associates the attribute ":image" with a file attachment

  has_attached_file :image, :styles => { :medium => "300x300#", :thumb => "200x200#" }
  validates_attachment :image, content_type: { content_type:     ["image/jpg", "image/jpeg", "image/png"] }







  def full_name
    "#{first_name.capitalize} #{last_name.capitalize}"
  end

  def full_address_1
    "#{address}, #{address2}"
  end

  def full_address_2
    "#{city}, #{state} #{zip}"
  end

  def manager?
    if is_manager?
      "Manager "
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

  def find_average_monthly_shifts
    if ((created_at) > Time.now + 1.month )
      (employee_shifts.count /  ((Time.now.year * 12 + Time.now.month) - (created_at.year * 12 + created_at.month).to_f)).round(2)
    else
      employee_shifts.count
    end
  end

  def shift_today
    EmployeeShift.where(employee_id: id && :date == Date.today.day)
  end

end
