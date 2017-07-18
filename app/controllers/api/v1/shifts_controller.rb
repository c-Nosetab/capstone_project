class Api::V1::ShiftsController < ApplicationController

  def index
    @shifts = Shift.where(company_id: current_user.company_id).order(:date)
  end

  def create
    # {"year_start"=>"2017", "month_start"=>"6", "day_start"=>"21", "hour_start"=>"8", "min_start"=>"0", "hour_end"=>"4", "min_end"=>"0", "company_id"=>"1"}
    date = Time.utc(params[:year_start], (params[:month_start]), params[:day_start], params[:hour_start], params[:min_start])
    @shift = Shift.create!(
                      day_of_week: date.strftime('%A').downcase,
                      time_start: date,
                      time_end: Time.utc(params[:year_start], params[:month_start], params[:day_start], params[:hour_end], params[:min_end]),
                      date: date,
                      company_id: params[:company_id]
                      )
    render :show
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
