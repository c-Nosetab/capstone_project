class UsersController < ApplicationController

  def new
  end

  def create

    user = Employee.new(
                    first_name: params[:first_name],
                    last_name: params[:last_name],
                    email: params[:email],
                    password: params[:password],
                    password_confirmation: params[:password_confirmation],
                    position_id: params[:position_id],
                    company_id: params[:company_id]
                    )
    if user.save
      session[:user_id] = user.id
      flash[:success] = "Successfully Created User"
      redirect_to "/employees/#{user.id}/edit"
    else
      flash[:warning] = "Invalid Email or Password"
      redirect_to "/signup"
    end
  end

end
