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
    @work.save!
    if @work.save
      redirect_to show_work_path(@work), notice: 'Work was successfully created.'
     else
       render action: 'new'
    end
  end

  private

  def work_params
    params.require(:work).permit(:title, :description, :tags, :image)
  end

end
