class UsersController < ApplicationController
  def show
    @user = User.find_by(id: params[:id])
    @articles = Article.where(user_id: @user.id) if @user
  end
end
