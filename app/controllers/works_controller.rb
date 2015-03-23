class WorksController < ApplicationController
  
  def list
    @works = Work.where(user_id: current_user.id)
  end
  
  def new
    @work = Work.new
  end

  def show
    @work = Work.find(params[:id])
  end

  def create
    @work = Work.new work_params
    @work.user_id = current_user.id
    if @work.save
      redirect_to show_work_path(@work), notice: 'Work was successfully created.'
     else
      flash[:alert] = @work.errors.full_messages
      render action: 'new'
    end
  end

  private

  def work_params
    params.require(:work).permit(:title, :description, :tags, :image)
  end
end
