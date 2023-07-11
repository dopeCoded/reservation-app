class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:edit_account, :edit_profile, :update]
  before_action :set_user, only: [:show, :edit_account, :edit_profile, :update]

  def index
    @reservations = current_user.reservations
  end
    
  def show
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to @user, notice: 'User was successfully created.'
    else
      render :new
    end
  end

  def edit_account
  end

  def edit_profile
  end
  
  def update
    if @user.update(user_params)
      redirect_to @user, notice: 'Profile was successfully updated.'
    else
      render :edit
    end
  end

  def reservations
    @reservations = @user.reservations
  end

  private

  def set_user
    @user = User.find(params[:id])
  end
  
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :avatar).delete_if { |_, v| v.blank? }
  end
end
