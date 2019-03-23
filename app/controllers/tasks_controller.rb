class TasksController < ApplicationController
  def create
    @task = Task.new(task_params)
    if @task.save
      return_task
    else
      error_400
    end
  end

  private

  def task_params
    params.permit(:name, :about, :project_id, :sprint_id)
  end

  def return_task
    render json: { task: @task }
  end

  def error_400
    render json: { errors: @task.errors }, status: :bad_request
  end
end
