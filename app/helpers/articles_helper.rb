module ArticlesHelper

  def truncate_article(article, word_count = 100)
    truncate(strip_tags(article.content.to_s), length: word_count, separator: ' ')
  end

  def rich_text(rich_text_object)
    rich_text_object.to_s
  end

  def return_img(article_content)
    content = rich_text(article_content)
    img_tags = content.scan(/<img.*?src=["'](.*?)["'].*?>/)
    if !img_tags[0].nil?
      Rails.logger.debug("img #{img_tags[0][0]}")
      image_url = img_tags[0][0]
      image_tag(image_url, class: "resize")
    end
  end

end
