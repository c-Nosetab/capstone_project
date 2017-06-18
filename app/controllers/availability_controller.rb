class AvailabilityController < ApplicationController

  def index
    @availabilities = Availability.where(employee_id: current_user.id)
  end

  def new
  end

  def create
    availability = Availability.new(

      )
  end

  def edit

  end

  def update

  end

  def destroy

  end

end
