class DropElementsTable < ActiveRecord::Migration[7.0]
  def up
    drop_table :elements
  end
  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
