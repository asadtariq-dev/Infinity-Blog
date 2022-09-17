# frozen_string_literal: true

class CreateReports < ActiveRecord::Migration[7.0]
  def change
    create_table :reports do |t|
      t.references :author, null: false, foreign_key: true
      t.references :post, null: true, foreign_key: true
      t.references :comment, null: true, foreign_key: true

      t.timestamps
    end

    add_index :reports, %i[author_id post_id comment_id], unique: true
  end
end
