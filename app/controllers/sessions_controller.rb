# sessions controller
class SessionsController < ApplicationController
  def new; end

  def edit; end

  def create
    # debugger
    user = User.find_by(email: params[:session][:email])
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      flash[:success] = "Welcome #{user.username}"
      redirect_to users_url
    else
      flash[:danger] = 'Check the input and try again'
      render :new
    end
  end

  def update; end

  def destroy
    session[:user_id] = nil
    flash[:danger] = 'logged out'
    redirect_to root_url
  end
end
