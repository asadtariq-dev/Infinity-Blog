# frozen_string_literal: true

class AddValidationsToPost < ActiveRecord::Migration[7.0]
  def change
    change_column :posts, :author_id, :bigint, presence: true, null: false
    change_column :posts, :title, :string, presence: true, null: false, length: { minimum: 5, maximum: 100 }
    change_column :posts, :description, :text, presence: true, null: false, length: { minimum: 5, maximum: 200 }
    change_column :posts, :content, :text, length: { minimum: 10, maximum: 2000 }
  end
end
