class FoundationalPagesController < ApplicationController
  def index
    @articles = Article.distinct.where(created_at: Time.now - 3.days...Time.now).sample(MAX_SLIDE_NUM)
    @rankers = User.joins(:articles).group(:id).order("count(articles.user_id) DESC")
                   .limit(5).shuffle
  end

  def help
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
    @categoryArticles = (category.to_a.first).articles.page(params[:page]).per(8) if !(category.empty?)
    @searchArticles = Article.where('title like ?', "%#{params[:search]}%").page(params[:page]).per(8)
  end
end
