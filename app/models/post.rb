# frozen_string_literal: true

class Post < ApplicationRecord
  # after_destroy :delete_post_belongings
  belongs_to :author
  has_rich_text :content
  has_one_attached :header_image
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :reports, dependent: :destroy
  has_many :suggestions, dependent: :destroy

  validates :title, :description, :header_image, :author_id, presence: true
  validates_length_of :title, within: 5..30
  validates_length_of :description, within: 5..100

  scope :published?, ->(post_id) { find(post_id).published? }
  scope :published, -> { where(published: true) }
  scope :pending, -> { where(pending: true) }
  scope :most_recent_posts, -> { order(published_at: :desc) }
  scope :delete_reports, ->(post_id) { find(post_id).reports.destroy_all }

  def delete_post_belongings
    puts '===========Hello==============='
    @post.comments.destroy_all
    @post.likes.destroy_all
    @post.suggestions.destroy_all
    @post.reports.destroy_all
  end
end
