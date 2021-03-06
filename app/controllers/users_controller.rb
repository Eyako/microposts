class UsersController < ApplicationController
  before_action :me?, only: [:edit, :update]
  before_action :set_params, only: [:show, :edit, :update, :followings, :followers]
  
  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.order(created_at: :desc)
  end
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Welcome to the Sample App!"
       redirect_to @user 
    else
      render 'new'
    end
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:info] = 'Profileを更新しました。'
      redirect_to @user
    else
      flash[:danger] = 'Profileの更新に失敗しました。'
      render 'edit'
    end
  end
  
  def followings
    @title = 'Following Users'
    @users = @user.following_users
    @current_page = "followings"

    render 'show_follow'
  end
  
  def followers
    @title = 'Follower_users'
    @users = @user.follower_users
    @current_page = "followers"
    render 'show_follow'
  end
  
  private

  def user_params
    params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation,:introduction,)
  end
  
  def me?
    @user = User.find(params[:id])
    if current_user != @user
      redirect_to root_path
    end
  end
  
  def set_params
    @user = User.find(params[:id])
  end
  
end
