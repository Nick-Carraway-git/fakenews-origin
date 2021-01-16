module ArticlesHelper
  def article_deleter(article)
    begin
      link_to article_path(article) do
        image_tag article.image.variant(combine_options:{resize:"500x400^",
                                                         crop:"500x400+0+0",
                                                         gravity: :center}).processed,
                                        class: 'picture-decoration'
      end
    rescue
      article.destroy
    end
  end
end
