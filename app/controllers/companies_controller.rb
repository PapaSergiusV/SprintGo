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
      error_406
    end
  end

  def update
    if @company.update(company_params)
      return_company
    else
      error_406
    end
  end

  def destroy
    @company.destroy
  end

  def workers
    ids = Role.where(company_id: params[:company_id]).pluck(:user_id).uniq
    works = User.where(id: ids)
    render json: {
      workers: works,
      count: works.length
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

  def error_406
    render json: { errors: @company.errors }, status: :not_acceptable
  end
end
