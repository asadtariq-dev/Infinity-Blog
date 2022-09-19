class RemoveAuthorFkOnLikes < ActiveRecord::Migration[7.0]
  def change
    remove_foreign_key :likes, :authors
  end
end
