class SearchController < ApplicationController
  def search
    @content = params["search"]["content"]
    @records = User.where("name like '%#{@content}%'")
  end
end
