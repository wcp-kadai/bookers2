class BookCommentsController < ApplicationController
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

  def edit
    @book_comment = BookComment.find(params[:id])
    @book = Book.find(params[:book_id])
  end

  def update
    @book_comment = BookComment.find(params[:id])
    @book = Book.find(params[:book_id])
    if @book_comment.update(book_comment_params)
      flash[:success] = "Commnet was successfully updated." 
      redirect_to book_path(@book)
    else
      render :edit
    end
  end

  def destroy
    book_comment = BookComment.find(params[:id])
    book = book_comment.book
    book_comment.destroy
    redirect_to book_path(book)
  end

  private

  def book_comment_params
    params.require(:book_comment).permit(:comment)
  end
end
