# frozen_string_literal: true

class AddAdminColumnToAuthor < ActiveRecord::Migration[7.0]
  def change
    add_column :authors, :admin, :boolean
    # Ex:- add_column("admin_users", "username", :string, :limit =>25, :after => "email")
  end
end
