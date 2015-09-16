class Supervisor::SubjectsController < ApplicationController
  load_and_authorize_resource

  def new
  end

  def create
    if @subject.save
      flash[:success] = flash_message "created"
    else
      flash.now[:danger] = flash_message "not_created"
    end
    redirect_to [:supervisor, @subject]
  end

  private
  def subject_params
    params.require(:subject).permit :id, :name, :description,
      tasks_attributes: [:id, :name, :description, :_destroy]
  end
end
