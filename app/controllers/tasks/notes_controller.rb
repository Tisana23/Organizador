class Tasks::NotesController < ApplicationController
  before_action :set_task
  def create
    @note = @task.notes.new(note_params)
    @note.user = current_user
    if @note.save
      redirect_to task_url(@task), notice: "Nota agregada"
    end
  end

  private

  def note_params
    params.require(:note).permit(:body)    
  end

  def set_task
    @task = Task.find(params[:task_id])
  end

end