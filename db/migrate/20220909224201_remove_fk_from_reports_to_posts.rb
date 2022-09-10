# frozen_string_literal: true

class RemoveFkFromReportsToPosts < ActiveRecord::Migration[7.0]
  def change
    remove_foreign_key :reports, :posts
  end
end
