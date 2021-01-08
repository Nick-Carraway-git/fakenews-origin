class FoundationalPagesController < ApplicationController
  def index
    @articles = Article.where(created_at: Time.now - 3.days...Time.now)
                       .order("RAND()").limit(MAX_SLIDE_NUM)
  end

  def help
  end

  def terms
  end

  def aboutus
  end
end
