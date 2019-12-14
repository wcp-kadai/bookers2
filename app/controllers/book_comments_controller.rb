class BookCommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_user, only: [:edit, :update, :destroy]

  def create
    # 同期処理はコメントアウト
    # @book = Book.find(params[:book_id])
    # @book_new = Book.new
    # @book_comment = @book.book_comments.new(book_comment_params)
    # @book_comment.user_id = current_user.id
    # if @book_comment.save
    #   flash[:success] = "Comment was successfully created."
    #   redirect_to book_path(@book)
    # else
    #   @book_comments = BookComment.where(id: @book)
    #   render 'books/show'
    # end
    book = Book.find(params[:book_id])
    @book_comment = book.book_comments.new(book_comment_params)
    @book_comment.user_id = current_user.id
    @book_comment.save
    # ここの処理まで終わるとapp/views/book_comments/create.js.erb(app/views/コントローラー名/アクション名.js.erb)のjavascriptコードが実行される
    # html.erbと同様にここで定義したインスタンス変数をjs.erbファイルでも使用することができる(今回@book_commentをcreate.js.erbで使用できる)
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

  def correct_user
    book_comment = BookComment.find(params[:id])
    if current_user != book_comment.user
      redirect_to book_path(book_comment.book)
    end

  end
end
