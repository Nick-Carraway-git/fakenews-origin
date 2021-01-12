class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:following, :followers, :favoring, :sended, :recieved]
  before_action :mail_checker, only: [:sended, :recieved]

  def show
    @user = User.find_by(id: params[:id])
    return redirect_to request.referrer || root_url if @user.blank?
    @articles = Article.where(user_id: @user.id)
    @boards = @user.boardrooms
  end

  def following
    @title = "Following"
    @user  = User.find(params[:id])
    @users = @user.following
    render 'show_follow'
  end

  def followers
    @title = "Followers"
    @user  = User.find(params[:id])
    @users = @user.followers
    render 'show_follow'
  end

  def favoring
    @title = "Favorite Articles"
    @user  = User.find(params[:id])
    @articles = @user.favoring
    render 'show_favorite'
  end

  def sended
    @title = "Sended"
    @minimails = current_user.send_minimails
    render 'minimails/index_minimails'
  end

  def recieved
    @title = "Recieved"
    @user  = User.find(params[:id])
    @minimails = current_user.recieve_minimails
    render 'minimails/index_minimails'
  end

  private

    def mail_checker
      check = current_user.id.equal?(params[:id].to_i)
      redirect_to root_url if check == false
    end
end
