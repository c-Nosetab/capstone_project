class Api::V1::ShiftsController < ApplicationController

  def index
    @shifts = Shift.where(company_id: current_user.company_id).order(:date)
    # @shifts = shifts.select{|shift| shift.date > (Time.now - 2.months) && shift.date < (Time.now + 2.months)}
  end

  def show
      @shift = Shift.find(params[:id])
      # .include(:employee_shifts, :company)
      @position_shifts = @shift.position_shifts
      @positions = Position.where(company_id: current_user.company_id)
      @employees = @shift.employees
      @unassigned_employees = []

      Availability.where(company_id: current_user.company_id, day_of_week: @shift.day_of_week).each do |avail|
        if avail.time_start <= @shift.time_start && avail.time_end >= @shift.time_end
          @unassigned_employees << avail.employee
        end
      end
    end

end
