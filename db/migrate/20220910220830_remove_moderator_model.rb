# frozen_string_literal: true

class RemoveModeratorModel < ActiveRecord::Migration[7.0]
  def change
    drop_table :moderators
  end
end
