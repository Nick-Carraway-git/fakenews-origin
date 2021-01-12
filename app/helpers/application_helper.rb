module ApplicationHelper
  # random jump用数字の追加
  def random_jump
    rand(1..(Article.all.count))
  end
end
