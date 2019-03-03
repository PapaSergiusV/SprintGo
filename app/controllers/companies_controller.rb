class CompaniesController < ApplicationController
  before_action :set_company, only: %i[show update destroy]

  def index
    render json: { companies: Company.all.slice(0, 10) }
  end

  def show
    return_company
  end

  def create
    logger.info "---#{params}---"
    @company = Company.new(company_params)
    if @company.save
      role = Role.new(name: 'Owner',
                      user_id: params[:user_id],
                      company_id: @company.id)
      role.save
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
    render json: { ok: true } if @company.destroy
  end

  # Return worker list of company
  def employees_list
    render json: {
      workers: company_employee_list(params[:company_id])
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
