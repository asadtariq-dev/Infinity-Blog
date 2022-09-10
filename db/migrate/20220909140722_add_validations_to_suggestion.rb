# frozen_string_literal: true

class AddValidationsToSuggestion < ActiveRecord::Migration[7.0]
  def change
    change_column :suggestions, :author_id, :bigint, presence: true, null: false
    change_column :suggestions, :post_id, :bigint, presence: true, null: false
    change_column :suggestions, :content, :text, presence: true, null: false, length: { minimum: 2, maximum: 200 }
  end
end
