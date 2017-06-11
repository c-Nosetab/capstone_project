class ShiftsController < ApplicationController

  def index
    @shifts = Shift.all
  end

  def new
  end

  def create
    shift = Shift.new(
                      day_of_week: params[:day_of_week],
                      time_start: params[:time_start],
                      time_end: params[:time_end],
                      title: params[:title],
                      is_recurring?: params[:is_recurring?],
                      date: params[:date]
                      )

    if shift.save
      flash[:success] = "Shift Created"
      redirect_to "/shifts"
    else
      flash[:warning] = "Something went wrong. Try again"
      render '/shifts/new'
    end

  end

  def show

  end

  def edit

  end

  def update

  end

  def destroy

  end

end
