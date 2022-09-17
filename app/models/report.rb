# frozen_string_literal: true

class Report < ApplicationRecord
  validates :author_id, uniqueness: { scope: %i[reportable_id reportable_type] }

  belongs_to :author
  belongs_to :reportable, polymorphic: true
end
