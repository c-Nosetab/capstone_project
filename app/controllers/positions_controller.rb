class PositionsController < ApplicationController
  before_action :authenticate_user!

  def index
    @positions = Position.where(company_id: current_user.company_id)
  end

  def new
  end

  def create
    position = Position.new(position_name: params[:position_name], company_id: current_user.company_id)

    if position.save
      if !current_user.position_id
        current_user.update(position_id: position.id)
      end
      flash[:success] = "Position successfully created."
      redirect_to "/positions"
    else
      flash[:warning] = "Something went wrong. Please try again."
      redirect_to '/employees'
    end
  end

  def show
    @position = Position.find(params[:id])
    @employees = Employee.where(position_id: params[:id])
  end

  def edit
    @position = Position.find(params[:id])
  end

  def update
    position = Position.find(params[:id])
    position.assign_attributes(position_name: params[:position_name])

    if position.save
      flash[:success] = "Position successfully updated."
      redirect_to "/positions/#{position.id}"
    else
      flash[:warning] = "Something went wrong. Please try again."
      redirect_to "/positions/#{position.id}/edit"
    end
  end

  def destroy
    position = Position.find(params[:id])

    if position.delete
      flash[:success] = "Position successfully deleted."
      redirect_to '/positions'
    else
      flash[:warning] = "Something went wrong. Please try again."
      redirect_to "/positions/#{position.id}"
    end
  end

end
