# frozen_string_literal: true

class AddEnumsForUserRole < ActiveRecord::Migration[7.0]
  def change
    remove_column :authors, :admin
    remove_column :authors, :moderator

    add_column :authors, :role, :integer, default: 0
  end
end
