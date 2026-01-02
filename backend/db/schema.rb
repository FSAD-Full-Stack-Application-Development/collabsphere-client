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

ActiveRecord::Schema[8.0].define(version: 2025_11_23_175729) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"
  enable_extension "pgcrypto"

  create_table "api_logs", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "ip_address"
    t.string "user_agent"
    t.string "request_method"
    t.string "request_path"
    t.text "request_params"
    t.integer "response_status"
    t.text "response_message"
    t.integer "user_id"
    t.float "duration"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["created_at"], name: "index_api_logs_on_created_at"
    t.index ["id"], name: "index_api_logs_on_id", unique: true
    t.index ["ip_address"], name: "index_api_logs_on_ip_address"
    t.index ["request_method"], name: "index_api_logs_on_request_method"
    t.index ["request_path"], name: "index_api_logs_on_request_path"
    t.index ["response_status"], name: "index_api_logs_on_response_status"
    t.index ["user_id"], name: "index_api_logs_on_user_id"
  end

  create_table "audit_logs", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "action", null: false
    t.string "resource_type"
    t.integer "resource_id"
    t.text "details"
    t.string "ip_address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.uuid "user_id", null: false
    t.index ["created_at"], name: "index_audit_logs_on_created_at"
    t.index ["id"], name: "index_audit_logs_on_id", unique: true
    t.index ["resource_type", "resource_id"], name: "index_audit_logs_on_resource_type_and_resource_id"
    t.index ["user_id"], name: "index_audit_logs_on_user_id"
  end

  create_table "collaboration_requests", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "status", default: "pending", null: false
    t.text "message"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.uuid "project_id", null: false
    t.uuid "user_id", null: false
    t.index ["id"], name: "index_collaboration_requests_on_id", unique: true
    t.index ["project_id", "user_id"], name: "index_collab_requests_on_project_and_user"
    t.index ["project_id"], name: "index_collaboration_requests_on_project_id"
    t.index ["status"], name: "index_collaboration_requests_on_status"
    t.index ["user_id"], name: "index_collaboration_requests_on_user_id"
  end

  create_table "collaborations", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "project_role", default: 1
    t.uuid "project_id", null: false
    t.uuid "user_id", null: false
    t.index ["id"], name: "index_collaborations_on_id", unique: true
    t.index ["project_id"], name: "index_collaborations_on_project_id"
    t.index ["user_id"], name: "index_collaborations_on_user_id"
  end

  create_table "comments", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.text "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.uuid "project_id", null: false
    t.uuid "user_id", null: false
    t.uuid "parent_id"
    t.boolean "is_hidden", default: false, null: false
    t.boolean "is_reported", default: false, null: false
    t.datetime "hidden_at"
    t.text "hidden_reason"
    t.uuid "hidden_by_id"
    t.integer "likes"
    t.index ["id"], name: "index_comments_on_id", unique: true
    t.index ["is_hidden"], name: "index_comments_on_is_hidden"
    t.index ["is_reported"], name: "index_comments_on_is_reported"
    t.index ["parent_id"], name: "index_comments_on_parent_id"
    t.index ["project_id"], name: "index_comments_on_project_id"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "funding_requests", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "project_id", null: false
    t.uuid "funder_id", null: false
    t.decimal "amount", precision: 12, scale: 2, null: false
    t.text "note"
    t.string "status", default: "pending", null: false
    t.uuid "verified_by"
    t.datetime "verified_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["funder_id"], name: "index_funding_requests_on_funder_id"
    t.index ["project_id", "funder_id", "status"], name: "index_funding_requests_on_project_id_and_funder_id_and_status"
    t.index ["project_id"], name: "index_funding_requests_on_project_id"
    t.index ["status"], name: "index_funding_requests_on_status"
  end

  create_table "funds", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.decimal "amount", precision: 12, scale: 2
    t.datetime "funded_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.uuid "project_id", null: false
    t.uuid "funder_id", null: false
    t.index ["funder_id"], name: "index_funds_on_funder_id"
    t.index ["id"], name: "index_funds_on_id", unique: true
    t.index ["project_id", "funder_id"], name: "index_funds_on_project_id_and_funder_id"
    t.index ["project_id"], name: "index_funds_on_project_id"
  end

  create_table "messages", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.text "content"
    t.datetime "sent_at"
    t.boolean "is_read", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.uuid "sender_id", null: false
    t.uuid "receiver_id", null: false
    t.uuid "project_id"
    t.index ["id"], name: "index_messages_on_id", unique: true
    t.index ["is_read"], name: "index_messages_on_is_read"
    t.index ["project_id"], name: "index_messages_on_project_id"
    t.index ["receiver_id"], name: "index_messages_on_receiver_id"
    t.index ["sender_id", "receiver_id"], name: "index_messages_on_sender_id_and_receiver_id"
    t.index ["sender_id"], name: "index_messages_on_sender_id"
  end

  create_table "notifications", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "user_id", null: false
    t.string "notification_type", null: false
    t.string "notifiable_type", null: false
    t.uuid "notifiable_id", null: false
    t.uuid "actor_id"
    t.text "message", null: false
    t.json "metadata"
    t.boolean "read", default: false, null: false
    t.datetime "read_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["created_at"], name: "index_notifications_on_created_at"
    t.index ["notifiable_type", "notifiable_id"], name: "index_notifications_on_notifiable_type_and_notifiable_id"
    t.index ["notification_type"], name: "index_notifications_on_notification_type"
    t.index ["user_id", "read"], name: "index_notifications_on_user_id_and_read"
    t.index ["user_id"], name: "index_notifications_on_user_id"
  end

  create_table "project_stats", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.integer "total_views"
    t.integer "total_votes"
    t.integer "total_comments"
    t.datetime "last_updated"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.uuid "project_id", null: false
    t.index ["id"], name: "index_project_stats_on_id", unique: true
    t.index ["project_id"], name: "index_project_stats_on_project_id"
    t.index ["total_views"], name: "index_project_stats_on_total_views"
    t.index ["total_votes"], name: "index_project_stats_on_total_votes"
  end

  create_table "project_tags", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.uuid "project_id", null: false
    t.uuid "tag_id", null: false
    t.index ["id"], name: "index_project_tags_on_id", unique: true
    t.index ["project_id"], name: "index_project_tags_on_project_id"
    t.index ["tag_id"], name: "index_project_tags_on_tag_id"
  end

  create_table "projects", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.string "status"
    t.string "visibility"
    t.boolean "show_funds"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "project_phase"
    t.decimal "funding_goal", precision: 12, scale: 2
    t.decimal "current_funding", precision: 12, scale: 2, default: "0.0"
    t.uuid "owner_id", null: false
    t.boolean "is_hidden", default: false, null: false
    t.boolean "is_reported", default: false, null: false
    t.datetime "hidden_at"
    t.text "hidden_reason"
    t.uuid "hidden_by_id"
    t.index ["created_at"], name: "index_projects_on_created_at"
    t.index ["id"], name: "index_projects_on_id", unique: true
    t.index ["is_hidden"], name: "index_projects_on_is_hidden"
    t.index ["is_reported"], name: "index_projects_on_is_reported"
    t.index ["owner_id"], name: "index_projects_on_owner_id"
    t.index ["status"], name: "index_projects_on_status"
    t.index ["visibility"], name: "index_projects_on_visibility"
  end

  create_table "reports", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "reportable_type", null: false
    t.uuid "reportable_id", null: false
    t.string "reason", null: false
    t.text "description"
    t.string "status", default: "pending", null: false
    t.datetime "resolved_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.uuid "reporter_id", null: false
    t.uuid "resolved_by_id"
    t.index ["id"], name: "index_reports_on_id", unique: true
    t.index ["reportable_type", "reportable_id"], name: "index_reports_on_reportable"
    t.index ["reporter_id"], name: "index_reports_on_reporter_id"
    t.index ["resolved_by_id"], name: "index_reports_on_resolved_by_id"
    t.index ["status"], name: "index_reports_on_status"
  end

  create_table "resources", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.string "url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.uuid "project_id", null: false
    t.uuid "added_by_id", null: false
    t.string "status", default: "pending"
    t.index ["added_by_id"], name: "index_resources_on_added_by_id"
    t.index ["id"], name: "index_resources_on_id", unique: true
    t.index ["project_id"], name: "index_resources_on_project_id"
  end

  create_table "tags", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "tag_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["id"], name: "index_tags_on_id", unique: true
  end

  create_table "user_tags", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.uuid "user_id", null: false
    t.uuid "tag_id", null: false
    t.index ["id"], name: "index_user_tags_on_id", unique: true
    t.index ["tag_id"], name: "index_user_tags_on_tag_id"
    t.index ["user_id", "tag_id"], name: "index_user_tags_on_user_id_and_tag_id", unique: true
    t.index ["user_id"], name: "index_user_tags_on_user_id"
  end

  create_table "users", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "full_name"
    t.string "email"
    t.string "password_digest"
    t.string "system_role"
    t.text "bio"
    t.string "avatar_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "country"
    t.string "university"
    t.string "department"
    t.boolean "is_suspended", default: false, null: false
    t.boolean "is_reported", default: false, null: false
    t.datetime "suspended_at"
    t.text "suspended_reason"
    t.uuid "suspended_by_id"
    t.integer "age"
    t.string "occupation"
    t.text "short_term_goals"
    t.text "long_term_goals"
    t.text "immediate_questions"
    t.string "computer_equipment"
    t.string "connection_type"
    t.index ["id"], name: "index_users_on_id", unique: true
    t.index ["is_reported"], name: "index_users_on_is_reported"
    t.index ["is_suspended"], name: "index_users_on_is_suspended"
  end

  create_table "votes", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "vote_type"
    t.datetime "voted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.uuid "project_id", null: false
    t.uuid "user_id", null: false
    t.index ["id"], name: "index_votes_on_id", unique: true
    t.index ["project_id"], name: "index_votes_on_project_id"
    t.index ["user_id", "project_id"], name: "index_votes_on_user_id_and_project_id", unique: true
    t.index ["user_id"], name: "index_votes_on_user_id"
  end

  add_foreign_key "audit_logs", "users"
  add_foreign_key "collaboration_requests", "projects"
  add_foreign_key "collaboration_requests", "users"
  add_foreign_key "collaborations", "projects"
  add_foreign_key "collaborations", "users"
  add_foreign_key "comments", "comments", column: "parent_id"
  add_foreign_key "comments", "projects"
  add_foreign_key "comments", "users"
  add_foreign_key "comments", "users", column: "hidden_by_id"
  add_foreign_key "funding_requests", "projects"
  add_foreign_key "funding_requests", "users", column: "funder_id"
  add_foreign_key "funding_requests", "users", column: "verified_by"
  add_foreign_key "funds", "projects"
  add_foreign_key "funds", "users", column: "funder_id"
  add_foreign_key "messages", "projects"
  add_foreign_key "messages", "users", column: "receiver_id"
  add_foreign_key "messages", "users", column: "sender_id"
  add_foreign_key "notifications", "users"
  add_foreign_key "notifications", "users", column: "actor_id"
  add_foreign_key "project_stats", "projects"
  add_foreign_key "project_tags", "projects"
  add_foreign_key "project_tags", "tags"
  add_foreign_key "projects", "users", column: "hidden_by_id"
  add_foreign_key "projects", "users", column: "owner_id"
  add_foreign_key "reports", "users", column: "reporter_id"
  add_foreign_key "reports", "users", column: "resolved_by_id"
  add_foreign_key "resources", "projects"
  add_foreign_key "resources", "users", column: "added_by_id"
  add_foreign_key "user_tags", "tags"
  add_foreign_key "user_tags", "users"
  add_foreign_key "users", "users", column: "suspended_by_id"
  add_foreign_key "votes", "projects"
  add_foreign_key "votes", "users"
end
