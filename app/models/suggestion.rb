class Suggestion < ApplicationRecord
  belongs_to :post
  belongs_to :author
  belongs_to :parent, class_name: 'Suggestion', optional: true
  has_many :suggestions, foreign_key: :parent_id
end
