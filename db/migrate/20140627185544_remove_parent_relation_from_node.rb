class RemoveParentRelationFromNode < ActiveRecord::Migration
  def change
  	remove_column :nodes, :parent_relation, :string
  end
end
