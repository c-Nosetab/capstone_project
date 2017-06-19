class PositionShift < ApplicationRecord
  belongs_to :position
  belongs_to :shift

  def find_quantity
    puts shift.employees.where(position_id: position_id).count
    quantity - (shift.employees.where(position_id: position_id).count)
  end

  def print_scheduled_num
    shift.employees.where(position_id: position_id).count
  end

  def print_scheduled
    shift.employees.where(position_id: position_id)
  end

  def assigned_ids

  end

end
