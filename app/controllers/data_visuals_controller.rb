class DataVisualsController < ApplicationController

  def index
    @company = Company.find(params[:company_id])
    @positions = Position.where(company_id: @company.id)
  end

end
