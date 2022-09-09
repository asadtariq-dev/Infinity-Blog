class AddValidationsToComment < ActiveRecord::Migration[7.0]
  def change
    change_column :comments, :content, :text, presence: true, null: false
    change_column :comments, :post_id, :bigint, presence: true, null: false
    change_column :comments, :author_id, :bigint, presence: true, null: false
  end
end
