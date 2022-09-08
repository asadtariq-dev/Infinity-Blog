# frozen_string_literal: true

class AddPostIdNullTrueToLikes < ActiveRecord::Migration[7.0]
  def change
    change_column_null :likes, :post_id, true
  end
end
