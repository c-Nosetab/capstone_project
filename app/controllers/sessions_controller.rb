class SessionsController < ApplicationController


def new
  if current_user
    redirect_to '/employees'
  end

  end

  def create
    user = Employee.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:success] = "Successfully Logged In"
      redirect_to "/employees/#{user.id}"
    else
      flash[:warning] = "Invalid email or password"
      redirect_to '/login'
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:success] = "Successfully Logged Out"
    redirect_to '/login'
  end

end
