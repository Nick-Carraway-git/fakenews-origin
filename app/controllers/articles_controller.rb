class ArticlesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :edit, :create, :destroy]
  before_action :correct_user, only: [:edit, :update, :destroy]

  def index
    @articles = Article.all.page(params[:page]).per(4)
  end

  def show
    @article = Article.find_by(id: params[:id])
    if @article.blank?
      redirect_to root_path
    end
    if user_signed_in?
      @boardroom = Boardroom.new
      @boardrooms = Boardroom.where(article_id: @article)
      if @boardrooms.size > BRANDNEW_BOARD_NOM
        @past_boardrooms = @boardrooms.last(@boardrooms.length - BRANDNEW_BOARD_NOM)
      end
    end
  end

  def new
    @article = Article.new
  end

  def edit
    @article = Article.find_by(id: params[:id])
  end

  def update
    @article = Article.find_by(id: params[:id])
    @article.update(article_params)
    redirect_to article_path(@article)
  end

  def create
    if params[:article][:category_ids] != [""]
      @article = current_user.articles.build(article_params)
      @article.image.attach(params[:article][:image])
      if @article.save
        redirect_to article_path(@article)
      else
        redirect_to new_article_path
      end
    else
      redirect_to new_article_path
    end
  end

  def destroy
    @article.destroy
    redirect_to request.referrer || root_url
  end

  private

  def article_params
    params.require(:article).permit(:title, :content, :image, :image_description, { category_ids: [] })
  end

  def correct_user
    @article = current_user.articles.find_by(id: params[:id])
    redirect_to root_url if @article.nil?
  end
end
