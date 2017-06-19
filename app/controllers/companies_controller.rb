class CompaniesController < ApplicationController
  before_action :authenticate_admin!, except: [:show]

  def new
  end

  def create
    company = Company.new(
                          name: params[:name],
                          )

    company.save

    # unless company.save
    #   flash[:warning] = "Something went wrong. Please try again."
    #   redirect_to '/signup'
    # end

    user = Employee.new(
                        first_name: params[:first_name],
                        last_name: params[:last_name],
                        password: params[:password],
                        password_confirmation: params[:password_confirmation],
                        is_admin?: true,
                        is_manager?: true,
                        email: params[:email],
                        company_id: company.id
                        )

    if user.save
      session[:user_id] = user.id

      flash[:success] = "Company Successfully Created"
      redirect_to "/positions/new"
    else
      flash[:warning] = "Something went wrong. Please try again."
      redirect_to '/signup'
    end
  end

  def show
      @company = Company.find(current_user.company_id)
  end

  def edit
    if current_user.is_admin?
      @company = Company.find(current_user.company_id)
    else
      redirect_to '/company'
    end
  end

  def update
    if current_user.is_admin?
      @company = Company.find(current_user.company_id)
      @company.assign_attributes(
                                 name: params[:name],
                                 phone: params[:phone],
                                 address: params[:address],
                                 address2: params[:address2],
                                 city: params[:city],
                                 state: params[:state],
                                 zip: params[:zip],
                                 unique_code: SecureRandom.hex(16)
                                )

      if @company.save
          flash[:success] = "Company successfully updated."
          redirect_to '/company'
        else
          flash[:warning] = "Something went wrong. Please try again."
          redirect_to "/company/edit"
        end
    else
      redirect_to '/company'
    end
  end

  def destroy
    if current_user.is_admin?
      company = Company.find(current_user.company_id)
      company_name = company.name
      employees = Employee.where(company_id: current_user.company_id)
      positions = Position.where(company_id: current_user.company_id)
      if company.destroy
        flash[:success] = "All information pertaining to #{company_name} has been deleted."
      else

      end
    else
      flash[:warning] = "Something went wrong. Please try again."
      redirect_to '/signup'
    end
  end

end
