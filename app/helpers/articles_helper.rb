module ArticlesHelper

  def truncate_article(article, word_count = 100)
    truncate(strip_tags(article.content.to_s), length: word_count, separator: ' ')
  end

end
