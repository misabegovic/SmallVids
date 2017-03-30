class SessionsController < ApplicationController
  def create
    user = User.find_by(username: params[:session][:username])

    #conditionals
    condition = user && user.authenticate(params[:session][:password])
    login(user.id) if condition
    flash.now[:error] = 'Invalid password or email' unless condition
    render :new unless condition
  end

  def destroy
    session[:user_id] = nil
    render :new
  end

  private

  def login(user_id)
    session[:user_id] = user_id
    flash[:notice] = 'Successfully logged in'
    redirect_to post_videos_path
  end
end