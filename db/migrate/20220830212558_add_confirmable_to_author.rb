# frozen_string_literal: true

class AddConfirmableToAuthor < ActiveRecord::Migration[7.0]
  def up
    add_column :authors, :confirmation_token, :string
    add_column :authors, :confirmed_at, :datetime
    add_column :authors, :confirmation_sent_at, :datetime
    add_column :authors, :unconfirmed_email, :string # Only if using reconfirmable
    add_index :authors, :confirmation_token, unique: true
    # User.reset_column_information # Need for some types of updates, but not for update_all.
    # To avoid a short time window between running the migration and updating all existing
    # authors as confirmed, do the following
    Author.update_all confirmed_at: DateTime.now
    # All existing user accounts should be able to log in after this.
  end

  def down
    remove_index :authors, :confirmation_token
    remove_columns :authors, :confirmation_token, :confirmed_at, :confirmation_sent_at
    remove_columns :authors, :unconfirmed_email # Only if using reconfirmable
  end
end
