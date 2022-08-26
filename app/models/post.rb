class Post < ApplicationRecord
  belongs_to :author
  has_rich_text :content
  has_one_attached :header_image
end
