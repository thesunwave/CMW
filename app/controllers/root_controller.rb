class RootController < ApplicationController
  def index
    @works = Work.all.order(created_at: :desc)
  end
end
