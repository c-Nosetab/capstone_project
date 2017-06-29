class Api::V1::PositionShiftController < ApplicationController

  def index
    @position_shifts = PositionShift.where(company_id: current_user.company_id)
  end

  def create
    @position_shift = PositionShift.new(
                                        shift_id: params[:shiftId],
                                        position_id: params[:positionId],
                                        quantity: params[:quantity],
                                        company_id: params[:companyId]
                                        )
    if @position_shift.save
      render 'index.json.jbuilder'
    end
  end

  def show
    @position_shift = PositionShift.find(params[:id])
  end

  def destroy
    @position_shift = PositionShift.find_by(
                                            position_id: params[:positionId],
                                            shift_id: params[:shiftId]
                                            )
    @position_shift.delete

  end


end
