class FoundationalPagesController < ApplicationController
  def index
    @articles = Article.distinct.where(created_at: Time.now - 3.days...Time.now).sample(MAX_SLIDE_NUM)
    # @articles = Article.distinct.where(created_at: Time.now - 3.days...Time.now).order("RAND()").limit(MAX_SLIDE_NUM)
    # TOCO(ranker用処理)
    @rankers = User.all.sample(5)
    # @rankers.each do |ranker|
    #    ranker.articles.count * ranker.favorited.count
    #  end
  end

  def help
  end

  def terms
  end

  def aboutus
  end

  def search
  end

  def results
    category = Category.where(id: params[:category])
    # 1件のActive Recordを配列化 -> 取り出し
    @categoryArticles = (category.to_a.first).articles if !(category.empty?)
    @searchArticles = Article.where('title like ?', "%#{params[:search]}%")
  end
end
