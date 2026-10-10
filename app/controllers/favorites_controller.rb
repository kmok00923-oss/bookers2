class FavoritesController < ApplicationController
  before_action :set_book

  def create
    user = Current.session.user
    favorite = user.favorites.new(book: @book)
    favorite.save
    redirect_back fallback_location: books_path
  end

  def destroy
    user = Current.session.user
    favorite = user.favorites.find_by(book: @book)
    favorite.destroy
    redirect_back fallback_location: books_path
  end

  private

  def set_book
    @book = Book.find(params[:book_id])
  end
end
