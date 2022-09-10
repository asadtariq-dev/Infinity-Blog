# frozen_string_literal: true

class AddEnumToPost < ActiveRecord::Migration[7.0]
  def change
    remove_column :posts, :published
    remove_column :posts, :published_at
    remove_column :posts, :pending
    remove_column :posts, :submitted
    remove_column :posts, :submitted_at

    add_column :posts, :status, :integer, default: 0
  end
end
