# frozen_string_literal: true

class AddNullFalseToName < ActiveRecord::Migration[7.0]
  def change
    change_column_null :authors, :first_name, false
    change_column_null :authors, :last_name, false
  end
end
