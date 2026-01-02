class ChangeReportableIdToUuid < ActiveRecord::Migration[8.0]
  def change
    # Remove the old index
    remove_index :reports, [:reportable_type, :reportable_id], name: "index_reports_on_reportable"

    # Change reportable_id from bigint to uuid
    # Since there are no reports, we can use a dummy USING clause
    change_column :reports, :reportable_id, :uuid, using: 'gen_random_uuid()'

    # Recreate the index
    add_index :reports, [:reportable_type, :reportable_id], name: "index_reports_on_reportable"
  end
end
