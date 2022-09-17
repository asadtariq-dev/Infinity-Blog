# frozen_string_literal: true

class Report < ApplicationRecord
  belongs_to :author
  belongs_to :reportable, polymorphic: true

  validates :author_id, uniqueness: { scope: %i[reportable_id reportable_type] }
end
