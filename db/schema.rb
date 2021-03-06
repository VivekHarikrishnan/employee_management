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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20140215200017) do

  create_table "employees", force: true do |t|
    t.string   "code"
    t.string   "name"
    t.string   "designation"
    t.string   "degree"
    t.string   "university"
    t.string   "college"
    t.string   "city"
    t.decimal  "experience",      precision: 10, scale: 2
    t.text     "address"
    t.string   "password_digest"
    t.string   "type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "is_deleted",                               default: false
  end

  create_table "employees_projects", force: true do |t|
    t.integer  "employee_id"
    t.integer  "project_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "project_tasks", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "projects", force: true do |t|
    t.string   "name"
    t.string   "client"
    t.string   "type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "is_deleted", default: false
  end

  create_table "time_sheets", force: true do |t|
    t.integer  "employees_projects_id"
    t.integer  "project_task_id"
    t.date     "date_of_sheet"
    t.time     "from_time"
    t.time     "to_time"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
