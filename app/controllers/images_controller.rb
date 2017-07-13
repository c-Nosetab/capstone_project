class ImagesController < ApplicationController

  def update
    @employee = Employee.find(params[:id])
    if @employee.update( employee_params )
      flash[:success] = "Image Uploaded"
      redirect_to "/employees/#{current_user.id}"
    else
      flash[:warning] = "Something went wrong, please try again"
      redirect_to "/employees/#{current_user.id}"
    end
  end



  private

  def employee_params
    params.require(:employee).permit(:image)
  end

end
