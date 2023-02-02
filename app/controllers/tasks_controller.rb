class TasksController < ApplicationController
  load_and_authorize_resource #gema cancancan, revisar ability
  before_action :set_task, only: [:show, :edit, :update, :destroy]


  def index
    # @tasks = Task.all
    @tasks = Task.joins(:participants).where(
      'owner_id = ? OR participants.user_id = ?',
      current_user.id,
      current_user.id
      ).group(:id) #el group es para que no se repitan tareas
  end

  def show
    
  end

  def new
    @task = Task.new
    #@task.participating_users.build
  end

  def create
    @task = Task.new(task_params)
    @task.owner = current_user
    if @task.save
      redirect_to task_url(@task)
    else
      # @task.participating_users.build
      render :new
    end
  end

  def edit
    @task.participating_users.build
  end

  def update
    if @task.update(task_params)
      redirect_to task_url(@task)
    else
      redirect_to tasks_url
    end
  end

  def destroy
    @task.destroy
    redirect_to tasks_url
  end

  private
  def set_task
      @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:name, :description, :category_id, :owner_id, :due_date, participating_users_attributes: [:id, :user_id, :_destroy])
  end

end
