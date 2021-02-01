class FoundationalPagesController < ApplicationController
  def index
    @articles = Article.where(created_at: Time.now - 240.days...Time.now).distinct.sample(MAX_SLIDE_NUM)
    @rankers = User.joins(:articles).group(:id).order("count(articles.user_id) DESC").limit(5).shuffle
  end

  def specification
  end

  def contact
  end

  def aboutus
  end

  def search
  end

  def results
    category = Category.where(id: params[:category])
    # 1件のActive Recordを配列化 -> 取り出し
    @category_articles = category.to_a.first.articles.page(params[:page]).per(4) if !category.empty?
    @search_articles = Article.where('title like ?', "%#{params[:search]}%").page(params[:page]).per(4)
  end
end
