class CreateEmployees < ActiveRecord::Migration
  def change
    create_table :employees do |t|
      t.string :name
      t.string :address
      t.integer :salary_type
      t.integer :salary_unit
      t.integer :commissioned
      t.integer :payment_type
      t.references :union_member

      t.timestamps
    end
    add_index :employees, :union_member_id
  end
end
