class FavoritesController < ApplicationController
  def create
    @book = Book.find(params[:book_id])
    favorite = @book.favorites.new(user_id: current_user.id)
    favorite.save
    redirect # 下で定義したメソッドを呼び出し
  end

  def destroy
    @book = Book.find(params[:book_id])
    favorite = current_user.favorites.find_by(book_id: @book.id)
    favorite.destroy
    redirect # 下で定義したメソッドを呼び出し
  end

  private
  def redirect
    case params[:redirect_id].to_i
    when 0 # books/indexページからいいねした場合
      redirect_to books_path
    when 1 # books/showページからいいねした場合
      redirect_to book_path(@book)
    end
  end
end
