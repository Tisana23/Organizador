class TasksController < ApplicationController
  before_action :set_task, only: [:show]


  def index
    @tasks = Task.all
  end

  def show
    
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    @task.owner = current_user
    if @task.save
      render :index
    else
      render :new
    end
  end

  private
  def set_task
      @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:name, :description, :category_id, :owner_id, :due_date)
  end

end