class Comment < ApplicationRecord
  belongs_to :article
  belongs_to :user
  has_many :child_comments, class_name: 'Comment', foreign_key: 'parent_id'
  belongs_to :parent_comment, class_name: 'Comment', optional: true
end


# You can also retrieve the comments of an article by calling article.comments,
# and the child comments by calling comment.child_comments