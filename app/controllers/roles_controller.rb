class RolesController < ApplicationController
  def create
    @role = Role.new(role_params)
    if @role.save
      render json: { role: @role.name }
    else
      render json: { errors: @role.errors }, status: :bad_request
    end
  end

  def destroy
    @role = Role.find(params[:id])
    @role.destroy
    render json: {}, status: :ok
  end

  def companies_list
    ids = Role.where(user_id: params[:user_id])
              .pluck(:company_id).uniq
    companies = []
    Company.where(id: ids).each do |c|
      companies.push(
        id: c.id,
        name: c.name,
        logo: c.logo,
        about: c.about,
        address: c.address,
        phone: c.phone,
        created: c.created_at,
        projects: c.projects,
        workers: company_employee_list(c.id)
      )
    end
    render json: { companies: companies }
  end

  private

  def role_params
    params.require(:role).permit(:name, :user_id)
          .merge(params.permit(:company_id))
  end
end
