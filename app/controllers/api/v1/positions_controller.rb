class Api::V1::PositionsController < ApplicationController



  def index
    @positions = Position.where(company_id: current_user.company_id)
  end

  def show
    @position = Position.find(params[:id])
  end

end
