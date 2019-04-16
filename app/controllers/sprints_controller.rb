class SprintsController < ApplicationController
  before_action :set_sprint, only: %i[show update destroy]

  def index
    @sprints = Sprint.all.where(project_id: params[:project_id])
    render json: { sprints: @sprints }
  end

  def show
    render json: { tasks: Task.where(sprint_id: params[:id]) }
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
    render json: {}, status: :ok
  end

  private

  def sprint_params
    params.permit(:name, :project_id).merge(deadline: set_date)
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

  def set_date
    date = params[:deadline].split('.')
    Time.new(date[2], date[1], date[0]).in_time_zone
  end
end
