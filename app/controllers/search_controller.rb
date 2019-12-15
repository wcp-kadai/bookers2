class SearchController < ApplicationController
  def search
    @model = params["search"]["model"].to_i
    @content = params["search"]["content"]
    @how = params["search"]["how"].to_i
    @records = search_for(@how, @model, @content)
  end

  private
  # model -> 0: User, 1: Book
  # 完全一致検索メソッド
  def perfect_match(model, content)
    if model == 0
      User.where(name: content)
    elsif model == 1
      Book.where(title: content)
    end
  end

  # 前方一致検索メソッド
  def forward_match(model, content)
    if model == 0
      User.where("name like '#{content}%'")
    elsif model == 1
      Book.where("title like '#{content}%'")
    end
  end

  # 後方一致検索メソッド
  def backward_match(model, content)
    if model == 0
      User.where("name like '%#{content}'")
    elsif model == 1
      Book.where("title like '%#{content}'")
    end
  end

  # 部分一致検索メソッド
  def partial_match(model, content)
    if model == 0
      User.where("name like '%#{content}%'")
    elsif model == 1
      Book.where("title like '%#{content}%'")
    end
  end

  # how -> 0: 完全一致, 1: 前方一致, 2: 後方一致, 3: 部分一致
  def search_for(how, model, content)
    case how
    when 0
      perfect_match(model, content)
    when 1
      forward_match(model, content)
    when 2
      backward_match(model, content)
    when 3
      partial_match(model, content)
    end
  end

end
