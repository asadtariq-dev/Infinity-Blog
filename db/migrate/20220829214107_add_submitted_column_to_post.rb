class AddSubmittedColumnToPost < ActiveRecord::Migration[7.0]
  def change
    add_column :posts, :submitted, :boolean
    add_column :posts, :submitted_at, :datetime
    #Ex:- add_column("admin_users", "username", :string, :limit =>25, :after => "email")
  end
end
