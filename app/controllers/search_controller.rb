class SearchController < ApplicationController
  before_action :authenticate_user!

  def index
    @model = params["search"]["model"]
    @content = params["search"]["content"]
    @records = search_for(@model, @content)
  end

  private
  def search_for(model, content) # モデルと検索ワードによって検索するメソッド
    if model == 'user' # 対象モデルがUserの場合
      User.where("name like ?", "%#{content}%")
    elsif model == 'book' # 対象モデルがBookの場合
      Book.where("title like ?", "%#{content}%")
    end
  end

end
