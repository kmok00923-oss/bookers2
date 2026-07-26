class UsersController < ApplicationController
  allow_unauthenticated_access only: %i[ new create ]
  before_action :set_user, only: %i[ show edit update ]
  before_action :ensure_correct_user, only: %i[ edit update ]

  def index
    @users = User.all
    @new_book = Book.new
  end

  def show
    @new_book = Book.new
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      start_new_session_for @user
      redirect_to @user, notice: "Welcome! You have signed up successfully."
    else
      flash.now[:alert] = "An error occurred."
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user), notice: "User was successfully updated."
    else
      flash.now[:alert] = "An error occurred."
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def ensure_correct_user
    unless @user == Current.session.user
      redirect_to Current.session.user, alert: "An error occurred."
    end
  end

  def user_params
    params.require(:user).permit(:name, :email_address, :password, :password_confirmation, :introduction, :profile_image)
  end
end