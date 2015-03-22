class WorksController < ApplicationController
  def list
    @works = Work.all
  end

  def new
    @work = Work.new
  end

  def show
    @work = Work.find(params[:id])
  end

  def create
    @work = Work.create(work_params)

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
