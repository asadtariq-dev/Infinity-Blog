# frozen_string_literal: true

class ChangeColumnInPost < ActiveRecord::Migration[7.0]
  def change
    change_column :posts, :content, :text, null: true
    # Ex:- change_column("admin_users", "email", :string, :limit =>25)
  end
end
