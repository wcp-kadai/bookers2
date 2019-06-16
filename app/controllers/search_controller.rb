class SearchController < ApplicationController
  def search
    @model = params["search"]["model"] 
    @content = params["search"]["content"]
    @how = params["search"]["how"]
    @datas = search_for(@how, @model, @content) 
  end

  private
  def perfect_match(model, content)
    if model == 'user'
      User.where(name: content)
    elsif model == 'book'
      Book.where(title: content)
    end
  end

  def forward_match(model, content)
    if model == 'user'
      User.where("name like '#{content}%'")
    elsif model == 'book'
      Book.where("title like '#{content}%'")
    end
  end

  def backward_match(model, content)
    if model == 'user'
      User.where("name like '%#{content}'")
    elsif model == 'book'
      Book.where("title like '%#{content}'")
    end
  end

  def partial_match(model, content)
    if model == 'user'
      User.where("name like '%#{content}%'")
    elsif model == 'book'
      Book.where("title like '%#{content}%'")
    end
  end

  def search_for(how, model, content)
    case how
    when 'perfect'
      perfect_match(model, content)
    when 'forward'
      forward_match(model, content)
    when 'backward'
      backward_match(model, content)
    when 'partial'
      partial_match(model, content)
    end
  end

end
