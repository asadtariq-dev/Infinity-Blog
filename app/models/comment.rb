# frozen_string_literal: true

class Comment < ApplicationRecord
  validates :content, :post_id, :author_id, presence: true
  validates_length_of :content, within: 1..100

  belongs_to :post
  belongs_to :author
  belongs_to :parent, class_name: 'Comment', optional: true
  has_many :comments, foreign_key: :parent_id, dependent: :destroy
  has_many :likes, as: :likeable, dependent: :destroy
  has_many :reports, as: :reportable, dependent: :destroy

  scope :not_reply, -> { where(parent_id: nil) }
end
