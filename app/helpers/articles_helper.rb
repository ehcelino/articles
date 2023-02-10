module ArticlesHelper

  def truncate_article(article, word_count = 100)
    truncated = truncate(strip_tags(article.content.to_s), length: word_count, separator: ' ')
    content_tag(:p, truncated, class:"article-body")
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

  def link_to_previous_page(link_title)
    link_to_if(
      session[:previous_pages].present? && session[:previous_pages].size > 1,
      link_title, 
      session[:previous_pages].first, class: "lnk"
    )
  end


end
