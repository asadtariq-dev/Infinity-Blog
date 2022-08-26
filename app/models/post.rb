class Post < ApplicationRecord
  belongs_to :author
  has_rich_text :content
  has_one_attached :header_image

  validates :title, :description, presence: true
  validates_length_of :description, within: 20..200

  scope :published, -> do
    where(published: true)
  end

  scope :most_recent_posts, -> do
   order(published_at: :desc)
  end
end
