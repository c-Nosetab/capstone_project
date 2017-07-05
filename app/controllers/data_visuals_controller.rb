class DataVisualsController < ApplicationController

  def index
    @company = Company.find(params[:company_id])
  end

end
