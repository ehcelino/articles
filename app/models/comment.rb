class Comment < ApplicationRecord
  # before_save :set_depth
  # validate :depth_limit
  belongs_to :article
  belongs_to :user
  has_many :children, class_name: 'Comment', foreign_key: 'parent_id', dependent: :destroy
  belongs_to :parent, class_name: 'Comment', optional: true
  scope :roots, -> { where(parent_id: nil) }

  validates :title, presence: {message: "não pode estar em branco."}, blacklist: true
  validates :content, presence: {message: "não pode estar em branco."}, blacklist: true
  
  HUMANIZED_ATTRIBUTES = {
  :title => "Título",
  :content => "Conteúdo", 
  }

  def self.human_attribute_name(attr, options={})
    HUMANIZED_ATTRIBUTES[attr.to_sym] || super
  end

end


# You can also retrieve the comments of an article by calling article.comments,
# and the child comments by calling comment.child_comments