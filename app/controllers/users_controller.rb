class UsersController < ApplicationController
  before_filter :authenticate, :except => [:show, :new, :create]
  before_filter :correct_user, :only => [:edit, :update]
  before_filter :guest_user, :only => [:new, :create]
  before_filter :admin_user,   :only => :destroy
  before_filter :not_me,   :only => :destroy

  def index
    @users = User.paginate(:page => params[:page])
  end

  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.paginate(:page => params[:page])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      sign_in @user
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
    else
      @user.password = ""
      @user.password_confirmation = ""
      render 'new'
    end
  end

  def edit
  end

  def update
    if @user.update_attributes(params[:user])
      flash[:success] = "Profile updated."
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User destroyed."
    redirect_to users_path
  end

  def following
    @user = User.find(params[:id])
    @users = @user.following.paginate(:page => params[:page])
  end

  def followers
    @user = User.find(params[:id])
    @users = @user.followers.paginate(:page => params[:page])
  end

  private


    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user)
    end

    def not_me
      @user = User.find(params[:id])
      redirect_to(root_path) if current_user?(@user)
    end

    def guest_user
      if signed_in?
        flash[:notice] = "You must sign out before Signup new account."
        redirect_to(root_path)
      end
    end

    def admin_user
      redirect_to(root_path) unless current_user.admin?
    end
end

