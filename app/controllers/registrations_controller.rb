# class documentation comment
class RegistrationsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(registration_params)
    @user.is_admin = false
    register(@user.id) if @user.save
    render :new unless @user.save
  end

  private

  def registration_params
    params.require(:registration)
    .permit(:username, :password, :password_confirmation)
  end

  def register(user_id)
    session[:user_id] = user_id
    flash[:notice] = 'Successfully logged in'
    redirect_to post_videos_path
  end
end