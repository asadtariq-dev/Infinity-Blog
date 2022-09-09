class AddValidationsToAuthor < ActiveRecord::Migration[7.0]
  def change
    change_column :authors, :email, :string, presence: true, uniquness: true
    change_column :authors, :first_name, :string, presence: true, null: false, length: { minimum: 2, maximum: 10 }
    change_column :authors, :last_name, :string, presence: true, length: { minimum: 2, maximum: 10 }
  end
end
