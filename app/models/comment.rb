# frozen_string_literal: true

class Comment < ApplicationRecord
  validates :content, :post_id, :author_id, presence: true
  validates_length_of :content, within: 1..100

  belongs_to :post
  belongs_to :author
  belongs_to :parent, class_name: 'Comment', optional: true
  has_many :comments, foreign_key: :parent_id, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :reports, dependent: :destroy

  scope :is_comment, lambda {
    where(parent_id: nil).includes(:author)
  }
end
