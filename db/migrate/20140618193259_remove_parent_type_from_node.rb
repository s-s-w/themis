class RemoveParentTypeFromNode < ActiveRecord::Migration
  def change
  	remove_column :nodes, :parent_type, :string
  end
end
