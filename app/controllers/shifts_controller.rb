class ShiftsController < ApplicationController
  before_action :authenticate_user!


  def index
    @shifts = Shift.where(company_id: current_user.company_id)
  end

  def new
    @positions = Position.where(company_id: current_user.company_id)

  end

  def create

    date = Time.local(params[:year_start], params[:month_start], params[:day_start], params[:hour_start], params[:min_start])

    shift = Shift.new(
                      day_of_week: date.strftime('%A').downcase,
                      time_start: date,
                      time_end: Time.local(params[:year_start], params[:month_start], params[:day_start], params[:hour_end], params[:min_end]).ne,
                      title: params[:title],
                      is_recurring?: params[:is_recurring?],
                      date: date,
                      company_id: current_user.company_id
                      )

    if shift.save
      shift_position = PositionShift.new(
                                         position_id: params[:position],
                                         shift_id: shift.id,
                                         quantity: params[:quantity]
                                         )

      if shift_position.save
        flash[:success] = "Shift Successfully Created"
        redirect_to "/shifts/#{shift.id}"
      else
        flash[:warning] = "Something went wrong. Try again - position error"
        render '/shifts/new'
      end
    else
      flash[:warning] = "Something went wrong. Try again - shift error"
      render '/shifts/new'
    end

  end

  def show
    @shift = Shift.find(params[:id])
    @shift_positions = @shift.position_shifts
    @positions = Position.where(company_id: current_user.company_id)
    @employees = []

    Employee.where(company_id: current_user.company_id).each do |emp|
      emp.availabilities.each do |avail|
        if avail.day_of_week == @shift.day_of_week && avail.time_start <= @shift.time_start && avail.time_end >= @shift.time_end
          @employees << emp
        end
      end
    end

  end

  def edit
    @shift = Shift.find(params[:id])
    @positions = Position.where(company_id: current_user.company_id)

  end

  def update
    shift = Shift.find(params[:id])


    date = Time.local(params[:year_start], params[:month_start], params[:day_start], params[:hour_start], params[:min_start])


    shift.update_attributes(
                            day_of_week: date.strftime('%A').downcase,
                            time_start: date,
                            time_end: Time.local(2000,1,1, params[:hour_end], params[:min_end]),
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
    if shift.delete
      flash[:success] = "Shift successfully deleted."
      redirect_to '/shifts'
    else
      flash[:warning] = "Something went wrong. Please try again."
      redirect_to "/shifts/#{shift.id}"
    end
  end

end
