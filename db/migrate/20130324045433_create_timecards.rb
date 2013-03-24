class CreateTimecards < ActiveRecord::Migration
  def change
    create_table :timecards do |t|
      t.references :employee, :null => false
      t.date :record_date, :null => false
      t.decimal :hours, :precision => 3, :scale => 1, :null => false

      t.timestamps
    end
    add_index :timecards, :employee_id
  end
end
