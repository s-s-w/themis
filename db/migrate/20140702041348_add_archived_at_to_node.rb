class AddArchivedAtToNode < ActiveRecord::Migration
  def change
    add_column :nodes, :archived_at, :datetime
  end
end
