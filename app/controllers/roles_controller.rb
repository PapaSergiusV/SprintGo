class RolesController < ApplicationController
  def create
    @role = Role.new(role_params)
    if @role.save
      render json: { role: @role.name }
    else
      render json: { errors: @role.errors }, status: :not_acceptable
    end
  end

  def destroy
    @role = Role.find(params[:id])
    @role.destroy
  end

  private

  def role_params
    params.require(:role).permit(:name, :user_id)
          .merge(params.permit(:company_id))
  end
end
