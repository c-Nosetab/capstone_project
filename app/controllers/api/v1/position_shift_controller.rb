class Api::V1::PositionShiftController < ApplicationController

  def index
    @position_shifts = PositionShift.where(company_id: current_user.company_id)
  end

  def create
    @position_shift = PositionShift.new(
                                        shift_id: params[:shiftId],
                                        position_id: params[:positionId],
                                        quantity: params[:quantity]
                                        )
    if @position_shift.save
      render 'index.json.jbuilder'
    end

  end

end
