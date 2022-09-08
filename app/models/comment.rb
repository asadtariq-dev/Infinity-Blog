# frozen_string_literal: true

class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :author
  belongs_to :parent, class_name: 'Comment', optional: true
  has_many :comments, foreign_key: :parent_id, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :reports, dependent: :destroy

  validates :content, presence: true

  scope :is_comment, lambda {
    where(parent_id: nil).includes(:author)
  }
end
