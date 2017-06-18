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
                      time_end: Time.local(params[:year_start], params[:month_start], params[:day_start], params[:hour_end], params[:min_end]),
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
    @positions = @shift.position_shifts
  end

  def edit
    @shift = Shift.find(params[:id])
  end

  def update
    shift = Shift.find(params[:id])
    shift.update_attributes(
                            day_of_week: 1,
                            time_start: params[:time_start],
                            time_end: params[:time_end],
                            title: params[:title],
                            is_recurring?: params[:is_recurring?],
                            date: Time.local(params[:year_start], params[:month_start], params[:day_start])
                            )
    if shift.save
      flash[:success] = "Shift successfully updated."
      redirect_to "/shifts/#{shift.id}"
    else
      flash[:warning] = "Something went wrong. Please try again."
      redirect_to "/shifts/#{shift.id}/edit"
    end

    redirect_to "/shifts/#{shift.id}"
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
