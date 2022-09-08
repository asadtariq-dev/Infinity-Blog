# frozen_string_literal: true

class Report < ApplicationRecord
  belongs_to :author
  belongs_to :post, optional: true
  belongs_to :comment, optional: true
end
