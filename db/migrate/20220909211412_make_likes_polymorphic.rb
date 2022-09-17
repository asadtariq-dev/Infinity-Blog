# frozen_string_literal: true

class MakeLikesPolymorphic < ActiveRecord::Migration[7.0]
  def change
    rename_column :likes, :post_id, :likeable_id
    add_column :likes, :likeable_type, :string
    # Ex:- add_column("admin_users", "username", :string, :limit =>25, :after => "email")

    remove_column :likes, :comment_id

    remove_index :likes, %i[author_id likeable_id]
    add_index :likes, %i[author_id likeable_id likeable_type], unique: true
    add_index :likes, %i[likeable_id likeable_type]
  end
end
