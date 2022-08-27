class Like < ApplicationRecord
  validates :author_id, uniqueness: {scope: :post_id}
  belongs_to :author
  belongs_to :post
end
