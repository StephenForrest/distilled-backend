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

ActiveRecord::Schema[7.0].define(version: 2023_01_22_061130) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pgcrypto"
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

  create_table "integrations", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "workspace_id", null: false
    t.string "name", default: "", null: false
    t.integer "integration_type", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_integrations_on_user_id"
    t.index ["workspace_id"], name: "index_integrations_on_workspace_id"
  end

  create_table "integrations_slack", force: :cascade do |t|
    t.bigint "integration_id", null: false
    t.bigint "workspace_id", null: false
    t.text "token", null: false
    t.string "team_id", null: false
    t.string "team_name", default: "", null: false
    t.json "scopes", default: [], null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["integration_id"], name: "index_integrations_slack_on_integration_id"
    t.index ["workspace_id"], name: "index_integrations_slack_on_workspace_id"
  end

  create_table "measurement_slack_action_logs", force: :cascade do |t|
    t.bigint "measurements_slacks_id", null: false
    t.integer "metric", default: 0, null: false
    t.integer "value", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["measurements_slacks_id"], name: "index_measurement_slack_action_logs_on_measurements_slacks_id"
  end

  create_table "measurements", force: :cascade do |t|
    t.bigint "success_criteria_id", null: false
    t.integer "tracking_type", default: 0, null: false
    t.integer "tracking_status", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "workspace_id", null: false
    t.string "code"
    t.index ["success_criteria_id"], name: "index_measurements_on_success_criteria_id"
    t.index ["workspace_id"], name: "index_measurements_on_workspace_id"
  end

  create_table "measurements_slack", force: :cascade do |t|
    t.bigint "integrations_slack_id"
    t.bigint "workspace_id", null: false
    t.bigint "measurement_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "value", default: 0, null: false
    t.integer "metric", default: 0, null: false
    t.integer "metric_value", default: 0, null: false
    t.index ["integrations_slack_id"], name: "index_measurements_slack_on_integrations_slack_id"
    t.index ["measurement_id"], name: "index_measurements_slack_on_measurement_id"
    t.index ["workspace_id"], name: "index_measurements_slack_on_workspace_id"
  end

  create_table "measurements_slack_slack_channels", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.bigint "measurements_slack_id", null: false
    t.uuid "slack_channel_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["measurements_slack_id"], name: "index_mea_sl_sl_channels_on_measurements_slack_id"
    t.index ["slack_channel_id"], name: "index_measurements_slack_slack_channels_on_slack_channel_id"
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

  create_table "slack_channels", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.string "slack_channel_id"
    t.string "slack_team_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["slack_team_id", "slack_channel_id"], name: "index_slack_channels_on_slack_team_id_and_slack_channel_id", unique: true
  end

  create_table "slack_events", force: :cascade do |t|
    t.string "event_id", null: false
    t.string "team_id", null: false
    t.json "event", default: {}, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "tracked", default: false, null: false
    t.index ["event_id"], name: "index_slack_events_on_event_id"
    t.index ["team_id"], name: "index_slack_events_on_team_id"
  end

  create_table "stripe_customers", force: :cascade do |t|
    t.bigint "workspace_id", null: false
    t.string "stripe_customer_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["stripe_customer_id"], name: "index_stripe_customers_on_stripe_customer_id"
    t.index ["workspace_id"], name: "index_stripe_customers_on_workspace_id"
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

  create_table "user_email_verifications", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "token", null: false
    t.boolean "expired", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_user_email_verifications_on_user_id"
  end

  create_table "user_sessions", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "session_id", null: false
    t.boolean "expired", default: true, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "login_type", default: 0, null: false
    t.index ["user_id", "session_id"], name: "index_user_session", unique: true
    t.index ["user_id"], name: "index_user_sessions_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", limit: 255, null: false
    t.string "name", limit: 255, null: false
    t.string "password_encrypted", limit: 255
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "email_verified", default: false
    t.integer "invite_status", default: 0
    t.string "profile_pic", default: "f"
    t.index ["email"], name: "index_users_on_email"
  end

  create_table "workspace_members", force: :cascade do |t|
    t.bigint "workspace_id", null: false
    t.bigint "user_id", null: false
    t.integer "role", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.uuid "api_key", default: -> { "gen_random_uuid()" }, null: false
    t.index ["user_id"], name: "index_workspace_members_on_user_id"
    t.index ["workspace_id"], name: "index_workspace_members_on_workspace_id"
  end

  create_table "workspaces", force: :cascade do |t|
    t.string "title", limit: 255, null: false
    t.boolean "auto_created", default: true, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "domain"
    t.string "string"
    t.boolean "auto_join_from_domain", default: false, null: false
    t.boolean "boolean", default: false, null: false
    t.string "stripe_product"
  end

  add_foreign_key "measurements_slack_slack_channels", "measurements_slack"
  add_foreign_key "measurements_slack_slack_channels", "slack_channels"
  add_foreign_key "stripe_customers", "workspaces"
end
