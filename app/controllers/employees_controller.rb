class EmployeesController < ApplicationController

  def index
    @employees = Employee.all
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
                                password: params[:password],
                                password_digest: params[:password_digest],
                                is_admin?: params[:admin],
                                is_manager?: params[:manager],
                                position: params[:position],
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
                               password: params[:password],
                               password_digest: params[:password_digest],
                               is_admin?: params[:admin],
                               is_manager?: params[:manager],
                               position: params[:position],
                               phone: params[:phone],
                               email: params[:email]
                              )
    employee.save

    redirect_to "/employees/#{employee.id}"
  end

  def destroy
    employee = Employee.find(params[:id])
    employee.delete

    redirect_to '/'
  end


end
