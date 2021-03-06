# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130324045433) do

  create_table "employees", :force => true do |t|
    t.string   "name"
    t.string   "address"
    t.integer  "salary_type"
    t.integer  "salary_unit"
    t.integer  "commissioned"
    t.integer  "payment_type"
    t.integer  "union_member_id"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  add_index "employees", ["union_member_id"], :name => "index_employees_on_union_member_id"

  create_table "timecards", :force => true do |t|
    t.integer  "employee_id",                               :null => false
    t.date     "record_date",                               :null => false
    t.decimal  "hours",       :precision => 3, :scale => 1, :null => false
    t.datetime "created_at",                                :null => false
    t.datetime "updated_at",                                :null => false
  end

  add_index "timecards", ["employee_id"], :name => "index_timecards_on_employee_id"

  create_table "union_members", :force => true do |t|
    t.integer  "due"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

end
