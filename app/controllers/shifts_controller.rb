class ShiftsController < ApplicationController
  # before_action :authenticate_admin!


  def index

    @shifts = Shift.where(company_id: current_user.company_id).order('date')
    @time = Time.utc(Time.now.year, Time.now.month)
  end

  def new
    @positions = Position.where(company_id: current_user.company_id)

  end

  def create
    date = Time.utc(params[:year_start], params[:month_start], params[:day_start], params[:hour_start], params[:min_start])
    shift = Shift.new(
                      day_of_week: date.strftime('%A').downcase,
                      time_start: date,
                      time_end: Time.utc(params[:year_start], params[:month_start], params[:day_start], params[:hour_end], params[:min_end]),
                      title: params[:title],
                      is_recurring?: params[:is_recurring?],
                      date: date,
                      company_id: current_user.company_id
                      )
    if shift.save
      flash[:success] = "Shift Successfully Created"
      redirect_to "/shifts/#{shift.id}"
    else
      flash[:warning] = "Something went wrong. Try again - shift error"
      render "/company/#{current_user.company_id}/shifts"
    end
  end

  def show
    @shift = Shift.find(params[:id])
  end

  def edit
    @shift = Shift.find(params[:id])
    @positions = Position.where(company_id: current_user.company_id)
  end

  def update
    shift = Shift.find(params[:id])


    date = Time.utc(params[:year_start], params[:month_start], params[:day_start], params[:hour_start], params[:min_start])


    shift.update_attributes(
                            day_of_week: date.strftime('%A').downcase,
                            time_start: date,
                            time_end: Time.utc(2000,1,1, params[:hour_end], params[:min_end]),
                            title: params[:title],
                            is_recurring?: params[:is_recurring?],
                            date: date,
                            company_id: current_user.company_id
                            )
    if shift.save
      flash[:success] = "Shift successfully updated."
      redirect_to "/shifts/#{shift.id}"
    else
      flash[:warning] = "Something went wrong. Please try again."
      redirect_to "/shifts/#{shift.id}/edit"
    end
  end

  def destroy
    shift = Shift.find(params[:id])
    positions = shift.position_shifts
    employees = shift.employee_shifts
    if shift.delete
      positions.each {|pos| pos.delete}
      employees.each {|emp| emp.delete}
      flash[:success] = "Shift successfully deleted."
      redirect_to "/company/#{current_user.company_id}/shifts"
    else
      flash[:warning] = "Something went wrong. Please try again."
      redirect_to "/shifts/#{shift.id}"
    end
  end

end
