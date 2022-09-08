# frozen_string_literal: true

class Report < ApplicationRecord
  validates :author_id, presence: true

  belongs_to :author
  belongs_to :post, optional: true
  belongs_to :comment, optional: true
end
