# frozen_string_literal: true

class Suggestion < ApplicationRecord
  belongs_to :post
  belongs_to :author
  belongs_to :parent, class_name: 'Suggestion', optional: true
  has_many :suggestions, foreign_key: :parent_id, dependent: :destroy, inverse_of: :parent

  validates :content, presence: true
  validates :content, length: { within: 2..200 }
end
