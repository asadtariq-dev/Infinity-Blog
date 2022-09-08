# frozen_string_literal: true

class Suggestion < ApplicationRecord
  validates :post_id, :author_id, :content, presence: true
  validates_length_of :content, within: 5..200
  validates :parent_id, absence: true

  belongs_to :post
  belongs_to :author
  belongs_to :parent, class_name: 'Suggestion', optional: true
  has_many :suggestions, foreign_key: :parent_id
end
