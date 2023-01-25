module ApplicationHelper


  def render_comments(comments, depth = 0)
    comments.map do |comment|
      content_tag(:div, class: "comment", style: "padding-left: #{depth * 10}px;") do
        content_tag(:div, class:"title") do
        link_to(comment.title, new_comment_path(parent_id: comment.id, article_id: @article.id), class:"lnk") 
        end +
        content_tag(:div, class: "user") do
          comment.user.username
        end +
        content_tag(:div, class: "created_at") do
          comment.created_at
        end +
        content_tag(:div, class: "comment-content") do
          comment.content
        end +
        content_tag(:div) do
          link_to("Comentar", new_comment_path(parent_id: comment.id, article_id: @article.id), class:"lnk")
        end +
        content_tag(:br) +
        content_tag(:div, class: "children") do
          (render_comments(comment.children, depth + 1) if comment.children.any?).to_s
        end
      end
    end.join.html_safe
  end


end
