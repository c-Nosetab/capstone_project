class AvailabilityController < ApplicationController
  before_action :authenticate_user!

  def index
    if current_user.id == params[:user_id].to_i || current_user.is_admin?
      @availabilities = Availability.where(employee_id: params[:user_id])
      @employee = Employee.find(params[:user_id])
      @days_of_week = ['monday', 'tuesday', 'wednesday', 'thursday', 'friday', 'saturday', 'sunday']
    else
      redirect_to '/'
    end

  end

  def new
  end

  def create

    date_start = Time.utc(params[:year_start], params[:month_start], params[:day_start], params[:hour_start], params[:min_start] )
    date_end = Time.utc(params[:year_end], params[:month_end], params[:day_end], params[:hour_end], params[:min_end] )

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
      redirect_to "/employees/#{current_user.id}/availability/#{availability.id}"
    else
      flash[:warning] = "Something went wrong, please try again."
      redirect_to "/employees/#{current_user.id}/availability/new"
    end
  end

  def show
    if current_user.id == params[:user_id].to_i || current_user.is_admin?
      @availability = Availability.find(params[:id])
    else
      redirect_to '/'
    end
  end

  def edit
    if current_user.id == params[:user_id].to_i
      @availability = Availability.find(params[:id])
    else
      redirect_to "employees/#{params[:user_id]}/availability"
    end
  end

  def update
    if current_user.id == params[:user_id].to_i
      availability = Availability.find(params[:id])
    else
      redirect_to "/employees/#{params[:user_id]}/availability"
    end

    date_start = Time.utc(params[:year_start], params[:month_start], params[:day_start], params[:hour_start], params[:min_start] )
    date_end = Time.utc(params[:year_end], params[:month_end], params[:day_end], params[:hour_end], params[:min_end] )

    availability.assign_attributes(
                                   day_of_week: params[:day_of_week].downcase,
                                   time_start: date_start,
                                   time_end: date_end,
                                   start_date: date_start,
                                   end_date: date_end
                                  )
    if availability.save
      flash[:success] = "Availability updated!"
      redirect_to "/employees/#{current_user.id}/availability/#{availability.id}"
    else
      flash[:warning] = "Something went wrong, please try again."
      redirect_to "/employees/#{current_user.id}availability/#{availability.id}"
    end

  end

  def destroy
    availability = Availability.find(params[:id])

    if availability.delete
      flash[:success] = "Availability successfully deleted!"
      redirect_to "/employees/#{current_user.id}/availability"
    else
      flash[:warning] = "Something went wrong, please try again."
      redirect_to "/employees/#{current_user.id}/availability/#{availability.id}"
    end
  end

end
