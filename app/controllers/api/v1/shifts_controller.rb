class Api::V1::ShiftsController < ApplicationController

  def index
    @shifts = Shift.where(company_id: current_user.company_id)
  end

  def show
      @shift = Shift.find(params[:id])
      # .include(:employee_shifts, :company)
      # @shift_positions = @shift.position_shifts
      # @positions = Position.where(company_id: current_user.company_id)
      # employee_holder = Employee.where(company_id: current_user.company_id)
      # @employees = []

      # Availability.where(company_id: current_user.company_id, day_of_week: @shift.day_of_week).each do |avail|
      #   if avail.time_start <= @shift.time_start && avail.time_end >= @shift.time_end
      #     @employees << avail.employee
      #   end
      # end
    end

end
