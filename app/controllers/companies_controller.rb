class CompaniesController < ApplicationController
  before_action :set_company, only: %i[show update destroy]

  def index
    render json: { companies: Company.all.slice(0, 10) }
  end

  def show
    return_company
  end

  def create
    @company = Company.new(company_params)
    if @company.save
      return_company
    else
      error_400
    end
  end

  def update
    if @company.update(company_params)
      return_company
    else
      error_400
    end
  end

  def destroy
    @company.destroy
  end

  # Return worker list of company
  def employees_list
    roles = Role.where(company_id: params[:company_id])
    workers = []
    User.where(id: roles.pluck(:user_id).uniq).each do |w|
      workers.push(
        id: w.id,
        email: w.email,
        roles: roles.where(user_id: w.id).pluck(:name)
      )
    end
    render json: {
      workers: workers,
      count: workers.length
    }
  end

  private

  def company_params
    params.require(:company).permit(:name, :logo, :about,
                                    :phone, :address)
  end

  def set_company
    @company = Company.find(params[:id])
  end

  def return_company
    render json: { company: @company }
  end

  def error_400
    render json: { errors: @company.errors }, status: :bad_request
  end
end
