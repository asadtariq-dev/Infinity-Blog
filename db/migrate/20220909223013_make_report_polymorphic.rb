class MakeReportPolymorphic < ActiveRecord::Migration[7.0]
  def change
    rename_column :reports, :post_id, :reportable_id
    add_column :reports, :reportable_type, :string

    remove_column :reports, :comment_id

    add_index :reports, [:author_id, :reportable_id, :reportable_type], unique: true, name: "author_and_reportable_index"
    add_index :reports, [:reportable_id, :reportable_type]
  end
end
