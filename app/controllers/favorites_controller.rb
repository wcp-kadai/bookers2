class FavoritesController < ApplicationController
  def create
    @book = Book.find(params[:book_id])
    favorite = @book.favorites.new(user_id: current_user.id)
    favorite.save
    redirect
  end

  def destroy
    @book = Book.find(params[:book_id])
    favorite = current_user.favorites.find_by(book_id: @book.id)
    favorite.destroy
    redirect
  end

  private
  def redirect
    case params[:redirect_id].to_i
    when 0
      redirect_to books_path
    when 1
      redirect_to book_path(@book)
    end
  end
end
