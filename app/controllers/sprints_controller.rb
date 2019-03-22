class SprintsController < ApplicationController
  before_action :set_sprint, only: %i[show update destroy]

  def index
    @sprints = Sprint.all.where(project_id: params[:project_id])
    render json: { sprints: @sprints }
  end

  def show
    return_sprint
  end

  def create
    @sprint = Sprint.new(sprint_params)
    if @sprint.save
      return_sprint
    else
      error_400
    end
  end

  def update
    if @sprint.update(sprint_params)
      return_sprint
    else
      error_400
    end
  end

  def destroy
    @sprint.destroy
  end

  private

  def sprint_params
    params.permit(:name, :period, :project_id)
  end

  def set_sprint
    @sprint = Sprint.find(params[:id])
  end

  def return_sprint
    render json: { sprint: @sprint }
  end

  def error_400
    render json: { errors: @sprint.errors }, status: :bad_request
  end
end
