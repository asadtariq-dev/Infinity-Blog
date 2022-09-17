# frozen_string_literal: true

class CreateModerators < ActiveRecord::Migration[7.0]
  def change
    create_table :moderators, &:timestamps
  end
end
