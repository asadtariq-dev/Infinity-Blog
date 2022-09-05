class Post < ApplicationRecord
  belongs_to :author
  has_rich_text :content
  has_one_attached :header_image
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :reports, dependent: :destroy
  has_many :suggestions, dependent: :destroy

  validates :title, :description, :header_image, presence: true
  validates_length_of :description, within: 5..200

  scope :published?, lambda { |post_id|
    find(post_id).published?
  }

  scope :published, lambda {
    where(published: true)
  }

  scope :pending, lambda {
    where(pending: true)
  }

  scope :most_recent_posts, lambda {
    order(published_at: :desc)
  }

  scope :delete_reports, lambda { |post_id|
    find(post_id).reports.destroy_all
  }
end
