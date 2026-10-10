class BookCommentsController < ApplicationController
  before_action :set_book

  def create
    user = Current.session.user
    comment = user.book_comments.new(book: @book, comment: params[:book_comment][:comment])
    comment.save
    redirect_back fallback_location: book_path(@book)
  end

  def destroy
    user = Current.session.user
    comment = @book.book_comments.find(params[:id])

    # 自分のコメントだけ削除可能
    if comment.user_id == user.id
      comment.destroy
    end

    redirect_back fallback_location: book_path(@book)
  end

  private

  def set_book
    @book = Book.find(params[:book_id])
  end
end
