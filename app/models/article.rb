class Article < ApplicationRecord
  belongs_to :user
  belongs_to :category
  has_many :comments, dependent: :destroy
  has_rich_text :content
  has_many :likes, dependent: :destroy

  def liked?(user)
    !!self.likes.find{|like| like.user_id == user.id}
  end

  def date_time_changed?
    created_at.strftime("%Y-%m-%d %H:%M") != updated_at.strftime("%Y-%m-%d %H:%M")
  end
  
  def as_json(options = {})
    super(options.merge(methods: [:author_name, :content_plain_text]))
    
  end

  def content_plain_text
    ActionView::Base.full_sanitizer.sanitize(content.body.to_s)
  end

  def author_name
    user.fullname
  end
end
