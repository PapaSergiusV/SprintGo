class ProjectRolesController < ApplicationController
  def create_roles
    role_params[:role_ids].each do |role_id|
      ProjectRole.create!(role_id: role_id,
                          project_id: role_params[:project_id])
    end
    render json: {
      company: Project.find(role_params[:project_id]).company
    }, status: :ok
  end

  private

  def role_params
    params.permit(:project_id, :role_id, role_ids: [])
  end
end
