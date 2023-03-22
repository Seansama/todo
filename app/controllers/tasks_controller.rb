class TasksController < ApplicationController


  def index
    render json: Task.all, status: :ok
  end


  def show
    task = Task.find_by(id:params[:id])
    if task
      render json: task, status: :ok
    else
      render json: {error: "Task not found"}, status: :not_found
    end
  end

  # POST /tasks
  def create
    task = Task.create(task_params)
    if task.valid?
      render json: task, status: :created
    else
      render json: { errors: user.errors.full_messages },
             status: :unprocessable_entity
    end
  end

  def update
    task = Task.find_by(id:params[:id])

    if task
      task.update(task_params)
      render json: task, status: :accepted
    else
      render json: {error: "Task not found"}, status: :not_found
    end
  end

  # DELETE /tasks/{id}
  def destroy
    task = Task.find_by(id:params[:id])

    if task
      task.destroy
      head :no_content
    else
      render json: { error: "Task not found" }, status: :not_found
    end
  end


  private

  def task_params
    params.permit(
      :task_name, :task_description, :task_status, :user_id
    )
  end
end
