class ImagesController < ApplicationController

  def update
    if params[:employee]
      @employee = Employee.find(params[:id])

      if @employee.update( employee_params )
        flash[:success] = "Profile Image Changed"
        redirect_to "/employees/#{@employee.id}"
      else
        flash[:warning] = "Something went wrong, please try again"
        redirect_to "/employees/#{@employee.id}"
      end

    else
      flash[:warning] = "You Must Upload an Image Before Submitting"
      redirect_to "/employees/#{current_user.id}"
    end

  end



  private

  def employee_params
    params.require(:employee).permit(:image)
  end

end
