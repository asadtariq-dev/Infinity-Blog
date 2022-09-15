# frozen_string_literal: true

class Post < ApplicationRecord
  belongs_to :author
  has_rich_text :content
  has_one_attached :header_image
  has_many :likes, as: :likeable, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :reports, as: :reportable, dependent: :destroy
  has_many :suggestions, dependent: :destroy

  enum :status, %i[unpublished pending published], default: 0
  validates :title, :description, :header_image, presence: true
  validates :title, length: { within: 5..100 }
  validates :description, length: { within: 5..200 }

  scope :all_reported, -> { joins(:reports).distinct.order(id: :desc) }
  scope :all_pending, -> { pending.order(created_at: :desc) }
  scope :delete_reports, ->(post_id) { find(post_id).reports.destroy_all }
end
