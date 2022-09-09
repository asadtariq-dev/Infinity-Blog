class AddValidationsToReport < ActiveRecord::Migration[7.0]
  def change
    change_column :reports, :author_id, :bigint, presence: true, null: false
  end
end
