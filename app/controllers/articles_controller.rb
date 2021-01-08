class ArticlesController < ApplicationController
  def show
    @article = Article.find_by(id: params[:id])
    if user_signed_in?
      @boardroom = Boardroom.new
      @boardrooms = Boardroom.where(article_id: @article)
      if @boardrooms.size > BRANDNEW_BOARD_NOM
        @past_boardrooms = @boardrooms.last(@boardrooms.length - BRANDNEW_BOARD_NOM)
      end
      # @boardrooms = current_user.boardrooms
      # @nonboardrooms = Boardroom.where(id: UserBoardroom.where.not(user_id: current_user.id).pluck(:id))
    end
  end

  def new
    @article = Article.new
  end

  def create
    @article = current_user.articles.build(article_params)
    @article.image.attach(params[:article][:image])
    if @article.save
      redirect_to article_path(@article)
    else
      render root_url
    end
  end

  def destroy
  end

  private

    def article_params
      params.require(:article).permit(:title, :content, :image, :image_description, { category_ids: [] })
    end
end
