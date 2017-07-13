class ImagesController < ApplicationController

  def update
    @employee = Employee.find(params[:id])
    if @employee.update( employee_params )
      flash[:success] = "Profile Image Changed"
      redirect_to "/employees/#{@employee.id}"
    else
      flash[:warning] = "Something went wrong, please try again"
      redirect_to "/employees/#{@employee.id}"
    end
  end



  private

  def employee_params
    params.require(:employee).permit(:image)
  end

end
