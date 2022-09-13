# frozen_string_literal: true

class Comment < ApplicationRecord
  validates :post_id, :author_id, presence: true
  validate :image_or_content
  validates :image, presence: true, unless: :content
  validates_length_of :content, within: 0..100

  belongs_to :post
  belongs_to :author
  belongs_to :parent, class_name: 'Comment', optional: true
  has_one_attached :image
  has_many :comments, foreign_key: :parent_id, dependent: :destroy
  has_many :likes, as: :likeable, dependent: :destroy
  has_many :reports, as: :reportable, dependent: :destroy

  scope :not_reply, -> { where(parent_id: nil) }

  def image_or_content
    errors.add(:comment, 'text or image must be present') if image.blank? && content.blank?
  end
end
