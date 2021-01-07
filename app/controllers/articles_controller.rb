class ArticlesController < ApplicationController
  def show
    @article = Article.find_by(id: params[:id])
  end

  def new
    @article = Article.new
  end

  def create
    @article = current_user.articles.build(article_params)
    @article.image.attach(params[:article][:image])
    if @article.save
      redirect_to root_url
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
