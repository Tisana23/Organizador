class TasksController < ApplicationController
  load_and_authorize_resource #gema cancancan, revisar ability
  before_action :set_task, only: [:show, :edit, :update]


  def index
    @tasks = Task.all
  end

  def show
    
  end

  def new
    @task = Task.new
    @task.participating_users.build
  end

  def create
    @task = Task.new(task_params)
    # @task.owner = current_user
    if @task.save
      redirect_to task_path(@task)
    else
      render :index
    end
  end

  def edit
    @task.participating_users.build
  end

  def update
    if @task.update(task_params)
      redirect_to task_path(@task)
    else
      redirect_to tasks_path
    end
  end

  private
  def set_task
      @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:name, :descrption, :category_id, :owner_id, :due_date, participating_users_attributes: [:id, :user_id, :_destroy])
  end

end
