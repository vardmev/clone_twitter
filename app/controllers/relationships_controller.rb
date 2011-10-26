class RelationshipsController < ApplicationController
  before_filter :authenticate

  def create
    @user = User.find(params[:relationship][:followed_id])
    current_user.follow!(@user)
    redirect_to @user
    if @user.follower_notification?
      UserMailer.send_email(@user, current_user).deliver
    end
  end

  def destroy
    @user = Relationship.find(params[:id]).followed
    current_user.unfollow!(@user)
    redirect_to @user
  end
end

