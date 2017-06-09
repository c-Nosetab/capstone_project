class EmployeesController < ApplicationController

  def index
    @employees = Employee.all

    sort = params[:sort]

    if sort
      @employees = Employee.where(position_id: sort)
    end

  end

  def new
  end

  def create

    employee = Employee.new(
                            first_name: params[:first_name],
                            last_name: params[:last_name],
                            address: params[:address],
                            address2: params[:address2],
                            city: params[:city],
                            state: params[:state],
                            zip: params[:zip],
                            is_admin?: params[:is_admin?],
                            is_manager?: params[:is_manager?],
                            position_id: params[:position_id],
                            phone: params[:phone],
                            email: params[:email]
                            )
    if employee.save
      flash[:success] = "Employee Created"
      redirect_to "/employees/#{employee.id}"
    else
      flash[:warning] = "Something went wrong, please try again"
      render "/employees/new"
    end

  end

  def show
    @employee = Employee.find(params[:id])
  end

  def edit
    @employee = Employee.find(params[:id])
  end

  def update
    employee = Employee.find(params[:id])
    employee.assign_attributes(
                               first_name: params[:first_name],
                               last_name: params[:last_name],
                               address: params[:address],
                               address2: params[:address2],
                               city: params[:city],
                               state: params[:state],
                               zip: params[:zip],
                               is_admin?: params[:is_admin?],
                               is_manager?: params[:is_manager?],
                               position_id: params[:position_id],
                               phone: params[:phone],
                               email: params[:email]
                              )
    employee.save

    redirect_to "/employees/#{employee.id}"
  end

  def destroy
    employee = Employee.find(params[:id])

    if employee.delete
      flash[:success] = "Employee Successfully Deleted"
      redirect_to '/employees'
    else
      flash[:warning] = "Something went wrong there. Try again."
    end
  end


end
