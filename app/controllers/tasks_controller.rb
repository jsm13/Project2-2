class TasksController < ApplicationController

  def new
    @project = Project.find(params[:project_id])
    @task = Task.new
  end

  def create
    @project = Project.find(params[:project_id])
    @task = @project.tasks.new(task_params)
    if @task.save
      flash[:notice] = "Woohoo! New task created."
      redirect_to project_path(@project)
    else
      render :new
    end
  end

  def show
    @task = Task.find(params[:id])
    @due_in = @task.due_in
    @task.set_priority
  end

  def edit
    @project = Project.find(params[:project_id])
    @task = Task.find(params[:id])
  end

  def update
    @project = Project.find(params[:project_id])
    @task = Task.find(params[:id])
    if @task.update(task_params)
      flash[:notice] = "Good new! Everything went smoothly and your task is updated."
      redirect_to project_task_path(@project, @task)
    else
      render :edit
    end
  end

  def destroy
    @task = Task.find(params[:id])
    @project = @task.project
    @task.destroy
    redirect_to project_path(@project)
  end

  # def assign
  #   @task = Task.find(params[:id])
  #   Assignment.create(user: current_user, task: @task)
  #   redirect_to project_task_path(@task.project, @task)
  # end

  private

  def task_params
    params.require(:task).permit(:name, :priority, :due_date, :status)
  end
end
