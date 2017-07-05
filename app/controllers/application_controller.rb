class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session


    def current_user
      @current_user ||= Employee.find_by(id: session[:user_id]) if session[:user_id]
    end
    helper_method :current_user

    # def shift_today
    #   @employee_shifts = Employee_shifts.where(employee_id: current_user.id) if current_user

    # end
    # helper_method :employee_shifts

  private

    def authenticate_user!
      redirect_to '/login' unless current_user
    end

    def authenticate_admin!
      redirect_to '/' unless current_user && current_user.is_admin?
    end



end
