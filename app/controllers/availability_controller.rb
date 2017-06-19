class AvailabilityController < ApplicationController
  before_action :authenticate_user!

  def index
    @availabilities = Availability.where(employee_id: current_user.id)
  end

  def new
  end

  def create

    date_start = Time.local(params[:year_start], params[:month_start], params[:day_start], params[:hour_start], params[:min_start] ).localtime
    date_end = Time.local(params[:year_end], params[:month_end], params[:day_end], params[:hour_end], params[:min_end] ).localtime

    availability = Availability.new(
                                    day_of_week: params[:day_of_week].downcase,
                                    time_start: date_start,
                                    time_end: date_end,
                                    start_date: date_start,
                                    end_date: date_end,
                                    employee_id: current_user.id
                                    )
    if availability.save
      flash[:success] = "Availability added"
      redirect_to "/availability/#{availability.id}"
    else
      flash[:warning] = "Something went wrong, please try again."
      redirect_to "/availability/new"
    end
  end

  def show
    @availability = Availability.find(params[:id])
  end

  def edit
    @availability = Availability.find(params[:id])
  end

  def update
    availability = Availability.find(params[:id])

    date_start = Time.local(params[:year_start], params[:month_start], params[:day_start], params[:hour_start], params[:min_start] ).localtime
    date_end = Time.local(params[:year_end], params[:month_end], params[:day_end], params[:hour_end], params[:min_end] ).localtime

    availability.assign_attributes(
                                   day_of_week: params[:day_of_week].downcase,
                                   time_start: date_start,
                                   time_end: date_end,
                                   start_date: date_start,
                                   end_date: date_end
                                  )
    if availability.save
      flash[:success] = "Availability updated!"
      redirect_to "/availability/#{availability.id}"
    else
      flash[:warning] = "Something went wrong, please try again."
      redirect_to "/availability/#{availability.id}"
    end

  end

  def destroy
    availability = Availability.find(params[:id])

    if availability.delete
      flash[:success] = "Availability successfully deleted!"
      redirect_to "/availability"
    else
      flash[:warning] = "Something went wrong, please try again."
      redirect_to "/availability/#{availability.id}"
    end
  end

end
