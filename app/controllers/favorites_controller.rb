class FavoritesController < ApplicationController
  def create
    @article = Article.find(params[:article_id])
    current_user.favor(@article)
    respond_to do |format|
      format.html { redirect_to @article }
      format.js
    end
  end

  def destroy
    @article = Favorite.find(params[:id]).article
    current_user.unfavor(@article)
    respond_to do |format|
      format.html { redirect_to @article }
      format.js
    end
  end
end
