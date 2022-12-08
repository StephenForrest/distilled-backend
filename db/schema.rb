# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2022_12_08_181133) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "actions", force: :cascade do |t|
    t.bigint "success_criteria_id", null: false
    t.integer "tracking_type", default: 0, null: false
    t.integer "action_object_id", default: -1, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "workspace_id", null: false
    t.index ["success_criteria_id"], name: "index_actions_on_success_criteria_id"
    t.index ["workspace_id"], name: "index_actions_on_workspace_id"
  end

  create_table "checklists", force: :cascade do |t|
    t.bigint "action_id", null: false
    t.json "settings", default: {}
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "workspace_id", null: false
    t.index ["action_id"], name: "index_checklists_on_action_id"
    t.index ["workspace_id"], name: "index_checklists_on_workspace_id"
  end

  create_table "focus_areas", force: :cascade do |t|
    t.bigint "plan_id", null: false
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["plan_id"], name: "index_focus_areas_on_plan_id"
  end

  create_table "goals", force: :cascade do |t|
    t.bigint "plan_id", null: false
    t.string "title", default: "", null: false
    t.datetime "expires_on"
    t.integer "tracking_status", default: 0, null: false
    t.integer "progress", default: 0, null: false
    t.bigint "owner_id", default: -1, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "workspace_id", null: false
    t.index ["plan_id"], name: "index_goals_on_plan_id"
    t.index ["workspace_id"], name: "index_goals_on_workspace_id"
  end

  create_table "measurements", force: :cascade do |t|
    t.bigint "success_criteria_id", null: false
    t.integer "measurement_type", default: 0, null: false
    t.integer "tracking_status", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "workspace_id", null: false
    t.index ["success_criteria_id"], name: "index_measurements_on_success_criteria_id"
    t.index ["workspace_id"], name: "index_measurements_on_workspace_id"
  end

  create_table "milestones", force: :cascade do |t|
    t.bigint "workspace_id", null: false
    t.bigint "action_id", null: false
    t.json "settings", default: {}
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["action_id"], name: "index_milestones_on_action_id"
    t.index ["workspace_id"], name: "index_milestones_on_workspace_id"
  end

  create_table "plans", force: :cascade do |t|
    t.bigint "workspace_id", null: false
    t.bigint "user_id", null: false
    t.string "name", default: "", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "uuid", default: "", null: false
    t.index ["user_id"], name: "index_plans_on_user_id"
    t.index ["workspace_id"], name: "index_plans_on_workspace_id"
  end

  create_table "success_criterias", force: :cascade do |t|
    t.bigint "goal_id", null: false
    t.integer "success_criteria_type", default: 0, null: false
    t.datetime "start_date"
    t.datetime "end_date"
    t.bigint "owner_id", default: -1, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "description", default: ""
    t.string "name", default: "", null: false
    t.bigint "workspace_id", null: false
    t.integer "tracking_status", default: 0, null: false
    t.index ["goal_id"], name: "index_success_criterias_on_goal_id"
    t.index ["workspace_id"], name: "index_success_criterias_on_workspace_id"
  end

  create_table "user_sessions", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "session_id", null: false
    t.boolean "expired", default: true, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id", "session_id"], name: "index_user_session", unique: true
    t.index ["user_id"], name: "index_user_sessions_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", limit: 255, null: false
    t.string "name", limit: 255, null: false
    t.string "password_encrypted", limit: 255, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email"
  end

  create_table "workspace_members", force: :cascade do |t|
    t.bigint "workspace_id", null: false
    t.bigint "user_id", null: false
    t.integer "role", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_workspace_members_on_user_id"
    t.index ["workspace_id"], name: "index_workspace_members_on_workspace_id"
  end

  create_table "workspaces", force: :cascade do |t|
    t.string "title", limit: 255, null: false
    t.boolean "auto_created", default: true, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
