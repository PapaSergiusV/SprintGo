class TasksController < ApplicationController
  before_action :set_task, only: %i[update destroy]

  def create
    @task = Task.new(task_params)
    if @task.save
      return_task
    else
      error_400
    end
  end

  def update
    if @task.update(task_params)
      return_task
    else
      error_400
    end
  end

  def destroy
    @task.destroy
    render json: {}, status: :ok
  end

  private

  def set_task
    @task = Task.find(params[:id])
  end

  def task_params
    params.permit(:name, :about, :project_id, :sprint_id, :state, :time)
  end

  def return_task
    render json: { task: @task }
  end

  def error_400
    render json: { errors: @task.errors }, status: :bad_request
  end
end
