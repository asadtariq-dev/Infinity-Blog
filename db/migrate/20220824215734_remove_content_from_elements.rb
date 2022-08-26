class RemoveContentFromElements < ActiveRecord::Migration[7.0]
  def up
    remove_column :elements, :content
  end
  def down
    add_column :elements, :content, :text
  end
end
