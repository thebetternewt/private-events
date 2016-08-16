class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @events = @user.events
    @previous_events = @user.previous_events
    @upcoming_events = @user.upcoming_events
  end

  def new
    @user = User.new
  end

  def create
    @user = User.build(user_params)
    if @user.save
      log_in @user
      redirect_to @user
    else
      render "new"
    end
  end

  private

    def user_params
      params.require(:user).permit(:username)
    end

end
