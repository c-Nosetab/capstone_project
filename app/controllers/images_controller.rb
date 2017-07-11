class ImagesController < ApplicationController

  def update
    @employee = Employee.find(params[:id])
    @employee.update( employee_params )
  end



  private

  def employee_params
    params.require(:employee).permit(:image)
  end

end
