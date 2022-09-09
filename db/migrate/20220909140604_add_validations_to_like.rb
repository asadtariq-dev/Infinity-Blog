class AddValidationsToLike < ActiveRecord::Migration[7.0]
  def change
    change_column :likes, :author_id, :bigint, presence: true, null: false
  end
end
