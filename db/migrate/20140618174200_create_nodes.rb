class CreateNodes < ActiveRecord::Migration
  def change
    create_table :nodes do |t|
      t.string :type
      t.text :summary
      t.text :body
      t.integer :parent_id
      t.string :parent_type
      t.boolean :in_support

      t.timestamps
    end
  end
end
