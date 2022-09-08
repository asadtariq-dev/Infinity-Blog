# frozen_string_literal: true

class AddLockableToDevise < ActiveRecord::Migration[7.0]
  def change
    add_column :authors, :failed_attempts, :integer, default: 0, null: false # Only if lock strategy is :failed_attempts
    add_column :authors, :locked_at, :datetime

    add_column :authors, :unlock_token, :string
    add_index :authors, :unlock_token, unique: true
  end
end
