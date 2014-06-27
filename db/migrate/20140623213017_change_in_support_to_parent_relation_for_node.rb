class ChangeInSupportToParentRelationForNode < ActiveRecord::Migration
  def up
  	change_column :nodes, :in_support, :string
  	rename_column :nodes, :in_support, :parent_relation
  end
  
  def down
  	rename_column :nodes, :parent_relation, :in_support
  	change_column :nodes, :in_support, :boolean
  end
end
