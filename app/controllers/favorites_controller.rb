class FavoritesController < ApplicationController
  def create
    @book = Book.find(params[:book_id])
    @render_flag = params[:render_flag]
    favorite = @book.favorites.new(user_id: current_user.id)
    favorite.save
    render 'books/favorite_change'
  end

  def destroy
    @book = Book.find(params[:book_id])
    @render_flag = params[:render_flag]
    favorite = current_user.favorites.find_by(book_id: @book.id)
    favorite.destroy
    render 'books/favorite_change'
  end
end
