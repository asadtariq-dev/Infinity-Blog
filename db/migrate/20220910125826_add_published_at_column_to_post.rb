# frozen_string_literal: true

class AddPublishedAtColumnToPost < ActiveRecord::Migration[7.0]
  def change
    add_column :posts, :published_at, :datetime
  end
end
