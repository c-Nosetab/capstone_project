class EmployeesController < ApplicationController
  before_action :authenticate_user!

  def index



    sort = params[:sort]

    if sort
      @employees = Employee.where(position_id: sort, company_id: current_user.company_id)
    end

  end

  def new
  end

  def create

    unless current_user.is_admin?
      redirect_to '/employees'
    end

    employee = Employee.new(
                            first_name: params[:first_name],
                            last_name: params[:last_name],
                            password: "#{params[:last_name]}123",
                            is_admin?: params[:is_admin?],
                            is_manager?: params[:is_manager?],
                            position_id: params[:position_id],
                            email: params[:email],
                            company_id: current_user.company_id.to_i
                            )
    if employee.save!
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
    @positions = Position.where(company_id: current_user.company_id)
  end

  def update
    employee = Employee.find(params[:id])
    if current_user.id == employee.id
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
    elsif current_user.is_admin? && current_user.id != employee.id
      employee.assign_attributes(
                               is_admin?: params[:is_admin?],
                               is_manager?: params[:is_manager?],
                               position_id: params[:position_id],
                               email: params[:email]
                              )
    end
      employee.save!

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
