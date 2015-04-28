class SearchController < ApplicationController

  def search
    if params[:q].nil?
      @works = []
    else
      @works = Work.search params[:q]
    end
  end

end
