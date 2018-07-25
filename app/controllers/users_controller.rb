class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user, only: :destroy
  before_action :find_user, only: [:edit, :update, :show, :destroy]

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      log_in @user
      flash[:info] = t "flash.create_user_successful"
      redirect_to root_path
    else
      flash.now[:danger] = t "flash.create_user_eror"
      render :new
    end
  end

  def show
    redirect_to root_url unless @user
  end

  def index
    @users = User.paginate page: params[:page],
      per_page: Settings.users.per_page
  end

  def edit; end

  def update
    if @user.update_attributes user_params
      flash[:success] = t "flash.user_updated"
      redirect_to @user
    else
      render :edit
    end
  end

  def destroy
    flash[:success] = t "flash.user_deleted"
    redirect_to users_url
  end

  private

  def find_user
    @user = User.find_by id: params[:id]
    return if @user
    redirect_to root_path
    flash[:danger] = t "flash.cant_find_user"
  end

  def user_params
    params.require(:user).permit :name, :email, :password,
      :password_confirmation, :role
  end

  def logged_in_user
    return if logged_in?
    store_location
    flash[:danger] = t "flash.log_in"
    redirect_to login_url
  end

  def correct_user
    @user = User.find_by id: params[:id]
    redirect_to root_url unless current_user? @user
  end

  def admin_user
    redirect_to root_url unless current_user.admin?
  end
end