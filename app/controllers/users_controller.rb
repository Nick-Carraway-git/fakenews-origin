class UsersController < ApplicationController
  def show
    @user = User.find_by(id: params[:id])
    return redirect_to request.referrer || root_url if @user.blank?
    @articles = Article.where(user_id: @user.id)
    @boards = @user.boardrooms
  end
end
