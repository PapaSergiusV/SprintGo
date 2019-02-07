class CompaniesController < ApplicationController
  before_action :set_company, only: :update

  def index
    render json: { companies: Company.all.slice(0, 10) }
  end

  def create
    @company = Company.new(company_params)
    if @company.save
      return_company
    else
      render json: { errors: @company.errors }, status: 406
    end
  end

  def update
    if @company.update(company_params)
      return_company
    else
      render json: { errors: @company.errors }, status: 406
    end
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
end
