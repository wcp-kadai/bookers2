class BookCommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_user, only: [:edit, :update, :destroy]

  def create
    @book = Book.find(params[:book_id])
    @book_new = Book.new
    @book_comment = @book.book_comments.new(book_comment_params)
    @book_comment.user_id = current_user.id
    if @book_comment.save
      flash[:success] = "Comment was successfully created."
      redirect_to book_path(@book)
    else
      @book_comments = BookComment.where(id: @book)
      render 'books/show'
    end
  end

  private

  def book_comment_params
    params.require(:book_comment).permit(:comment)
  end

  def correct_user
    book_comment = BookComment.find(params[:id])
    if current_user != book_comment.user
      redirect_to book_path(book_comment.book)
    end

  end
end
