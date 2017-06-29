class Api::V1::EmployeeShiftsController < ApplicationController

  def index
    @employee_shifts = EmployeeShift.where(company_id: current_user.company_id)
  end

  def create
    @employee_shift = EmployeeShift.new(
                      shift_id: params[:shiftId],
                      employee_id: params[:employeeId],
                      company_id: params[:companyId]
                      )

    if @employee_shift.save
      render 'show.json.jbuilder'
    else
      # render :json {errors: @employee_shift.errors.full_message}, status: 422
    end
  end

  def show
    @employee_shift = EmployeeShift.find(params[:id])
  end

  def destroy
    @employee_shift = EmployeeShift.find_by(
                                            shift_id: params[:shiftId],
                                            employee_id: params[:employeeId]
                                            )
    @employee_shift.delete

  end


end
