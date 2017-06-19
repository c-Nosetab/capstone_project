class EmployeeShiftsController < ApplicationController
  before_action :authenticate_user!

  def create
    shift = Shift.find(params[:shift_id])

    shift_assign = EmployeeShift.new(
                                      shift_id: params[:shift_id],
                                      employee_id: params[:employee_id]
                                      )

    if shift_assign.save!
      flash[:success] = "Employee Successfully Scheduled"
      redirect_to "/shifts/#{shift.id}"
    else
      flash[:warning] = "Something went wrong, please try again."
      redirect_to "/shifts/#{shift_id}"
    end
  end

  def destroy
    item = EmployeeShift.find(params[:id])
    shift_id = item.shift_id

    if item.delete
      flash[:success] = "Employee Unassigned"
      redirect_to "/shifts/#{shift_id}"
    else
      flash[:warning] = "Something went wrong, please try again."
      redirect_to "/shifts/#{shift_id}"
    end
  end

end
