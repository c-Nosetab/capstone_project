class Api::V1::ShiftsController < ApplicationController

  def index
    @shifts = Shift.where(company_id: current_user.company_id).order(:date)
  end

  def create
    date = Time.utc(params[:year], params[:month], params[:day], params[:startHour], params[:startMinute])


    shift = Shift.new(
                      day_of_week: date.strftime('%A').downcase,
                      time_start: date,
                      time_end: Time.utc(params[:year], params[:month], params[:day], params[:endHour], params[:endMinute]),
                      date: date,
                      company_id: params[:companyId]
                      )

    if shift.save
      flash[:success] = "Shift Successfully Created"
      redirect_to "/shifts/#{shift.id}"
    else
      flash[:warning] = "Something went wrong. Try again - shift error"
      render '/shifts/new'
    end
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
