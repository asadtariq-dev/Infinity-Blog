class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :author
  belongs_to :parent, class_name: 'Comment', optional: true
  has_many :comments, foreign_key: :parent_id
  has_many :likes, dependent: :destroy
  has_many :reports, dependent: :destroy

  validates :content, presence: true
end
