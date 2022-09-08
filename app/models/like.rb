# frozen_string_literal: true

class Like < ApplicationRecord
  belongs_to :author
  belongs_to :post, optional: true
  belongs_to :comment, optional: true
end
