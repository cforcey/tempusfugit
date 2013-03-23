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

ActiveRecord::Schema.define(version: 20130323201810) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admins", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "admins", ["email"], name: "index_admins_on_email", unique: true
  add_index "admins", ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true

  create_table "clients", force: true do |t|
    t.string   "name",                    null: false
    t.string   "description"
    t.integer  "user_id"
    t.integer  "hourly_rate", default: 0, null: false
    t.text     "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "clients", ["name"], name: "index_clients_on_name"
  add_index "clients", ["user_id"], name: "index_clients_on_user_id"

  create_table "projects", force: true do |t|
    t.string   "name",                    null: false
    t.string   "description"
    t.integer  "user_id",                 null: false
    t.integer  "client_id",               null: false
    t.integer  "hourly_rate", default: 0, null: false
    t.text     "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "projects", ["client_id"], name: "index_projects_on_client_id"
  add_index "projects", ["name"], name: "index_projects_on_name"
  add_index "projects", ["user_id"], name: "index_projects_on_user_id"

  create_table "spans", force: true do |t|
    t.string   "name",                       null: false
    t.string   "description"
    t.integer  "user_id",                    null: false
    t.integer  "project_id",                 null: false
    t.datetime "start_at",                   null: false
    t.datetime "end_at",                     null: false
    t.boolean  "billable",    default: true, null: false
    t.datetime "invoiced_at"
    t.text     "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "spans", ["billable"], name: "index_spans_on_billable"
  add_index "spans", ["end_at"], name: "index_spans_on_end_at"
  add_index "spans", ["invoiced_at"], name: "index_spans_on_invoiced_at"
  add_index "spans", ["name"], name: "index_spans_on_name"
  add_index "spans", ["project_id"], name: "index_spans_on_project_id"
  add_index "spans", ["start_at"], name: "index_spans_on_start_at"
  add_index "spans", ["user_id"], name: "index_spans_on_user_id"

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "roles_mask"
    t.string   "first"
    t.string   "middle"
    t.string   "last"
    t.string   "organization"
    t.integer  "hourly_rate"
    t.string   "message"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["last", "first", "middle"], name: "index_users_on_last_and_first_and_middle"
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  add_index "users", ["roles_mask"], name: "index_users_on_roles_mask"

end
