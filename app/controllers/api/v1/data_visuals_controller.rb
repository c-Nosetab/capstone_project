class Api::V1::DataVisualsController < ApplicationController

  def show
    @data = Company.find(params[:company_id])

    # @company = Company.find(params[:company_id])
    # @positions = Position.where(company_id: @company.id)
    # @employees = Employee.where(company_id: @company.id)
    # @shifts = Shift.where(company_id: @company.id)
    # @employee_shifts = EmployeeShift.where(company_id: @company.id)
    # @position_shifts = PositionShift.where(company_id: @company.id)
    # @availabilities = Availability.where(company_id: @company.id)


  end

end
