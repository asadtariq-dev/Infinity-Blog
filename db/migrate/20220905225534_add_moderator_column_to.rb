# frozen_string_literal: true

class AddModeratorColumnTo < ActiveRecord::Migration[7.0]
  def change
    add_column :authors, :moderator, :boolean
  end
end
