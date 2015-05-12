class SearchController < ApplicationController

  def search
    if params[:q].nil?
      @works = []
    else
      response = Work.search params[:q]
      @works = response.records.to_a
    end
  end

end
