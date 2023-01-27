class Comment < ApplicationRecord
  # before_save :set_depth
  validate :depth_limit
  belongs_to :article
  belongs_to :user
  has_many :children, class_name: 'Comment', foreign_key: 'parent_id'
  belongs_to :parent, class_name: 'Comment', optional: true
  scope :roots, -> { where(parent_id: nil) }

  def depth_limit
    if self.depth >= Setting.comment_depth_limit
      errors.add(:base, "Comment depth limit exceeded")
    end
  end

  # def set_depth
  #   if parent.present?
  #     self.depth = parent.depth + 1
  #   else
  #     self.depth = 0
  #   end
  # end

end


# You can also retrieve the comments of an article by calling article.comments,
# and the child comments by calling comment.child_comments