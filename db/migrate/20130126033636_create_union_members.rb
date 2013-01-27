class CreateUnionMembers < ActiveRecord::Migration
  def change
    create_table :union_members do |t|
      t.integer :due

      t.timestamps
    end
  end
end
