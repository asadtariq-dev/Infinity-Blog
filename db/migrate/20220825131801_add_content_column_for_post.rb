# frozen_string_literal: true

class AddContentColumnForPost < ActiveRecord::Migration[7.0]
  def change
    add_column :posts, :content, :text
    # Ex:- add_column("admin_users", "username", :string, :limit =>25, :after => "email")
  end
end
