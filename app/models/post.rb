# frozen_string_literal: true

class Post < ApplicationRecord
  enum :status, %i[unpublished pending published], default: 0

  belongs_to :author
  has_rich_text :content
  has_one_attached :header_image
  has_many :likes, as: :likeable, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :reports, as: :reportable, dependent: :destroy
  has_many :suggestions, dependent: :destroy

  validates :title, :description, :header_image, :author_id, presence: true
  validates_length_of :title, within: 5..100
  validates_length_of :description, within: 5..200

  scope :delete_reports, ->(post_id) { find(post_id).reports.destroy_all }
end
