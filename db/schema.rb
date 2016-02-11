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

ActiveRecord::Schema.define(version: 20160202202519) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_admin_comments", force: :cascade do |t|
    t.string   "namespace"
    t.text     "body"
    t.string   "resource_id",   null: false
    t.string   "resource_type", null: false
    t.integer  "author_id"
    t.string   "author_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id", using: :btree
  add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace", using: :btree
  add_index "active_admin_comments", ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id", using: :btree

  create_table "compagnies", force: :cascade do |t|
    t.string   "name"
    t.string   "address"
    t.string   "zip"
    t.string   "city"
    t.string   "country"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "counters", force: :cascade do |t|
    t.string   "name"
    t.integer  "start"
    t.integer  "actual"
    t.integer  "number_char"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "compagny_id"
  end

  add_index "counters", ["compagny_id"], name: "index_counters_on_compagny_id", using: :btree

  create_table "flows", force: :cascade do |t|
    t.integer  "compagny_id"
    t.integer  "code"
    t.string   "name"
    t.text     "description"
    t.integer  "deliverable"
    t.date     "date_sale"
    t.integer  "level_id"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.integer  "counter_id"
    t.integer  "number",      default: 0
  end

  add_index "flows", ["compagny_id"], name: "index_flows_on_compagny_id", using: :btree
  add_index "flows", ["counter_id"], name: "index_flows_on_counter_id", using: :btree
  add_index "flows", ["level_id"], name: "index_flows_on_level_id", using: :btree

  create_table "levels", force: :cascade do |t|
    t.integer  "compagny_id"
    t.string   "name"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.integer  "sequence",    default: 0
    t.boolean  "removal",     default: false
  end

  add_index "levels", ["compagny_id"], name: "index_levels_on_compagny_id", using: :btree

  create_table "organizations", force: :cascade do |t|
    t.integer  "pipe_organization_id"
    t.string   "name"
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
    t.string   "update_time"
    t.boolean  "active_flag",          default: false
  end

  create_table "people", force: :cascade do |t|
    t.integer  "pipe_person_id"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "job"
    t.boolean  "active_flag",     default: true
    t.integer  "organization_id"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.date     "update_time"
    t.string   "name"
    t.string   "phone"
  end

  add_index "people", ["organization_id"], name: "index_people_on_organization_id", using: :btree

  create_table "userpermits", force: :cascade do |t|
    t.integer  "compagny_id"
    t.integer  "user_id"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.boolean  "priority",    default: false
  end

  add_index "userpermits", ["compagny_id"], name: "index_userpermits_on_compagny_id", using: :btree
  add_index "userpermits", ["user_id"], name: "index_userpermits_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.boolean  "admin",                  default: false, null: false
    t.string   "name",                   default: "f"
    t.string   "firstname",              default: "f"
    t.boolean  "active",                 default: true
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  add_foreign_key "counters", "compagnies"
  add_foreign_key "flows", "compagnies"
  add_foreign_key "flows", "counters"
  add_foreign_key "flows", "levels"
  add_foreign_key "levels", "compagnies"
  add_foreign_key "people", "organizations"
  add_foreign_key "userpermits", "compagnies"
  add_foreign_key "userpermits", "users"
end
