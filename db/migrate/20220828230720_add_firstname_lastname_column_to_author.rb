class AddFirstnameLastnameColumnToAuthor < ActiveRecord::Migration[7.0]
  def change
    add_column :authors, :first_name, :string, :null => false
    add_column :authors, :last_name, :string, :null => false
    #Ex:- add_column("admin_users", "username", :string, :limit =>25, :after => "email")
  end
end
