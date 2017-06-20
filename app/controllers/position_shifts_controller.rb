class PositionShiftsController < ApplicationController


  def create
    item = PositionShift.new(
                             position_id: params[:position_id],
                             shift_id: params[:shift_id],
                             quantity: params[:quantity]
                            )

    if item.save
      flash[:success] = "Position Added to Shift"
      redirect_to "/shifts/#{params[:shift_id]}"
    else
      flash[:warning] = "Something went wrong. Please try again."
      redirect_to "/shifts/#{params[:shift_id]}"
    end

  end


  def destroy
    item = PositionShift.find(params[:id])

    employees = item.shift.employees.where(position_id: item.position_id)

    employees.each do |employee|
      shift = EmployeeShift.find_by(shift_id: item.shift.id, employee_id: employee.id)
      shift.delete
    end

    shift_id = item.shift.id

    if item.delete
      flash[:success] = "Position Deleted from Shift"
      redirect_to "/shifts/#{shift_id}"
    else
      flash[:warning] = "Something went wrong. Please try again."
      redirect_to "/shifts/#{shift_id}"
    end

  end

end
