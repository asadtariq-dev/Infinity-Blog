# frozen_string_literal: true

class AddCommentColumnInLikes < ActiveRecord::Migration[7.0]
  def change
    add_reference :likes, :comment, index: true
    add_foreign_key :likes, :comments
  end
end
