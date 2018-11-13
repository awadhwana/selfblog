class UsersController < ApplicationController
  before_action :user_find, only: [:show, :edit, :update, :destroy]
  before_action :require_same_user, only: [:edit, :update, :destroy]
  def index
    @users = User.paginate(page: params[:page], per_page: 3)
    
  end
  def show
   
    @user_articles = @user.articles.paginate(page: params[:page], per_page: 5)
    # @user_paginate = user.paginate(page: params[:page], per_page: 2)
  end

  def new
    @user = User.new
  end

  def edit
             
  end

  def create     
      if @user.save
        session[:user_id] = @user.id
        flash[:success] = "Account created successfully!"
        redirect_to user_url(@user)
        else
        flash[:danger] = "Oops, couldn't create account. Please make sure you are using a valid email and password and try again."
        render :new
      end
  end

  def update
    if  @user.update(user_params)
      flash[:success] = "Account updated successfully!"
      redirect_to root_url
      else
      flash[:danger] = "Oops, couldn't update account. Please make sure you are using a valid email and password and try again."
      render :edit
    end
  end

  def destroy
    
    @user.destroy
    flash[:danger] = 'User was successfully deleted'
    redirect_to root_url
  
  end
  
  private
  
  def user_params
    # strong parameters - whitelist of allowed fields #=> permit(:name, :email, ...)
    # that can be submitted by a form to the user model #=> require(:user)
    params.require(:user).permit(:username, :email, :password)
  end

  def user_find
    @user = User.find(params[:id])
  end
  def require_same_user
    if @user != current_user && !current_user.admin?
      flash[:danger] = "You can only modify your own account"
      redirect_to users_url      
    end
    
  end
end
