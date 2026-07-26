class BooksController < ApplicationController
  before_action :set_book, only: %i[ show edit update destroy ]
  before_action :ensure_correct_user, only: %i[ edit update destroy ]

  def index
    @books = Book.all
    @new_book = Book.new
  end

  def show
    @new_book = Book.new
  end

  def new
    @book = Book.new
  end

  def create
    @book = Current.session.user.books.build(book_params)
    if @book.save
      redirect_to @book, notice: "Book was successfully created."
    else
      flash.now[:alert] = "An error occurred."
      @books = Book.all
      @new_book = @book
      render :index, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @book.update(book_params)
      redirect_to book_path(@book), notice: "Book was successfully updated."
    else
      flash.now[:alert] = "An error occurred."
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @book.destroy
    redirect_to books_path, notice: "Book was successfully destroyed."
  end

  private

  def set_book
    @book = Book.find(params[:id])
  end

  def ensure_correct_user
    unless @book.user == Current.session.user
      redirect_to books_path, alert: "An error occurred."
    end
  end

  def book_params
    params.require(:book).permit(:title, :body)
  end
end
