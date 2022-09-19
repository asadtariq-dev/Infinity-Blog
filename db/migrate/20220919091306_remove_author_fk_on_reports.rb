class RemoveAuthorFkOnReports < ActiveRecord::Migration[7.0]
  def change
    remove_foreign_key :reports, :authors
  end
end
