class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by email: params[:session][:email].downcase
    if user && user.authenticate(params[:session][:password])
      log_in user
      remember? user
      redirect_to root_path
    else
      flash.now[:danger] = t "flash.invalid_message"
      render :new
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end

  private

  def remember? user
    params[:session][:remember_me] == "1" ? remember(user) : forget(user)
  end
end
