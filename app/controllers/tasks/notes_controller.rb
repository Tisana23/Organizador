class Task::NotesController < ApplicationController
  before_action :set_task
  def create
    @note = @task.notes.new(note_params)
    @note.user = current_user
    byebug
    if @note.save
      task_ulr(@task)
    end
  end

  private

  def note_params
    params.require(:note).permit(:body)    
  end

  def set_task
    @task = task.find(params[:task_id])
  end

end