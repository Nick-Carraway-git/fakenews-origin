module ApplicationHelper
  # random jump用数字の追加
  def random_jump
    randomArticle = Article.all.sample
    if !(randomArticle.blank?)
      randomArticle.id
    else
      0
    end
  end
end
