class Article < ApplicationRecord
  belongs_to :user
  belongs_to :category
  has_many :comments, dependent: :destroy
  has_rich_text :content

  def date_time_changed?
    created_at.strftime("%Y-%m-%d %H:%M") != updated_at.strftime("%Y-%m-%d %H:%M")
  end
  
end
