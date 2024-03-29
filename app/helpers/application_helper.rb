module ApplicationHelper


  def render_comments(comments, depth = 0)
    comments.map do |comment|
      content_tag(:div, class: "comment", style: "padding-left: #{depth * 10}px;") do
        content_tag(:div, class:"comment-title") do
          link_to(comment.title, "#", class: "comment-link lnk", data: { title: comment.title, comment: comment.content }) 
        end +
        content_tag(:i, class: "comment-user") do
          comment.user.username
        end +
        content_tag(:div, class: "comment-user") do
          comment.created_at.strftime("%d/%m/%Y")
        end +
        content_tag(:div, class: "comment-content") do
          comment.content
        end +
        content_tag(:div) do
          if current_user.username != "Visitante"
            link_to("Comentar", new_comment_path(parent_id: comment.id, article_id: @article.id), data: { turbo_frame: dom_id(comment) }, class:"lnk")
          end
        end +
        content_tag(:div) do
          turbo_frame_tag dom_id(comment), autoscroll: "true"
        end +
        content_tag(:br) +
        content_tag(:div, class: "children") do
          (render_comments(comment.children, depth + 1) if comment.children.any?).to_s
        end
      end
    end.join.html_safe
  end

  def render_comments_max(comments, depth = 0, limit = Setting.comments_limit)
    qtty = comments.count
    comments = comments.first(limit).select {|comment| comment.parent.nil? }
    comments_html = comments.map do |comment|
      content_tag(:div, class: "comment", style: "padding-left: #{depth * 10}px;") do
        content_tag(:div, class:"comment-title") do
        comment.title
        end +
        # content_tag(:i, "", class: "fa-solid fa-user comment-user") +
        content_tag(:i, class: "comment-user") do
          comment.user.username
        end +
        content_tag(:div, class: "created_at") do
          comment.created_at
        end +
        content_tag(:div, class: "comment-content") do
          comment.content
        end 
        # content_tag(:div, class: "children") do
        #   (render_comments_max(comment.children, depth + 1, limit) if comment.children.any?).to_s
        # end
      end
    end.join.html_safe 
    if qtty > limit
      comments_html += content_tag(:div, "Total de comentários: #{qtty}", class: "total")
    end
    return comments_html
  end

  def form_error_notification(object)
    if object.errors.any?
      tag.div class: "error_messages alert-danger", id:"notice" do
        tag.ul class: "no-bullets" do  
          object.errors.full_messages.each do |message|
            concat content_tag(:li, message)
          end
        end
      end
    end
  end
  

end
