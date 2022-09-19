class RemoveAuthorFkOnComments < ActiveRecord::Migration[7.0]
  def change
    remove_foreign_key :comments, :authors
  end
end
