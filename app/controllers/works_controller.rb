class WorksController < ApplicationController
  
  def list
    @works = Work.where(user_id: current_user.id).order(created_at: :desc)
  end
  
  def new
    @work = Work.new
  end
  
  def edit
    @work = Work.find(params[:id])
    respond_with(@work)
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
  
  def update
    @work = Work.find(params[:id])
    if @work.update_attributes(work_params)
      flash[:notice] = "Successfully updated work."
      redirect_to show_work_path(@work), notice: 'Work was successfully updated.'
    end
  end
  
  def destroy
    @work = Work.find(params[:id])
    if @work.destroy
      redirect_to list_path, notice: 'Work was successfully deleted.'
    end
  end

  private

  def work_params
    params.require(:work).permit(:title, :description, :tags, :image)
  end
end
