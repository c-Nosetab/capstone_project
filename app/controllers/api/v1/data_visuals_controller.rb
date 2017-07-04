class Api::V1::DataVisualsController < ApplicationController

  def show
    @data = Company.find(params[:company_id])
  end

end
