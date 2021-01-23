module ApplicationHelper
  # random jump用数字の追加
  def random_jump
    random_article = Article.all.sample
    if random_article.present?
      random_article.id
    else
      0
    end
  end
end
