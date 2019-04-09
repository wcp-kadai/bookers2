class BooksController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_user, only: [:update, :destroy, :edit]

  def index
    @books = Book.all
    @book = Book.new
  end

  def show
    @book = Book.new
    @book_show = Book.find(params[:id])
  end

  def create
    @books = Book.all
    @book = current_user.books.build(book_params)
    if @book.save
      flash[:success] = "Book was successfully created."
      redirect_to book_path(@book)
    else
      render :index
    end
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:success] = "Book was successfully updated."
      redirect_to book_path(@book)
    else
      render :edit
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end

  private
  def book_params
    params.require(:book).permit(:title, :opinion)
  end

  def correct_user
    book = Book.find(params[:id])
    if current_user.id != book.user.id
      redirect_to user_path(current_user)
    end
  end
end
