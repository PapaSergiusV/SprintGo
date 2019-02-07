class ProjectsController < ApplicationController
  before_action :set_project, only: [:show, :update, :destroy]

  def index
    @projects = Project.where(company_id: params[:company_id])
    render json: { projects: @projects }
  end

  def show
    return_project
  end

  def create
    @project = Project.new(project_params)
    if @project.save
      return_project
    else
      error_406
    end
  end

  def update
    if @project.update(project_params)
      return_project
    else
      error_406
    end
  end

  def destroy
    if @project.destroy
      render json: { status: :ok }
    else
      error_406
    end
  end

  private

  def project_params
    params.require(:project).permit(:name, :about).merge(params.permit(:company_id))
    # params.require(:project).permit(:name, :about)
  end

  def set_project
    @project = Project.find(params[:id])
  end

  def return_project
    render json: { project: @project }
  end

  def error_406
    render json: { errors: @project.errors }, status: 406
  end
end
