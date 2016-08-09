class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by(username: params[:session][:username])
    if user
      log_in user
      flash[:success] = "Welcome #{user.username}!"
      redirect_to user
    else
      flash.now[:danger] = "Invalid username."
      render 'new'
    end
  end

  def destroy
    log_out
    flash[:success] = "Logged out."
    redirect_to root_url
  end

end
