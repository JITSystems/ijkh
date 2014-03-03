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

ActiveRecord::Schema.define(:version => 20140303070243) do

  create_table "accounts", :force => true do |t|
    t.integer  "user_id"
    t.integer  "service_id"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
    t.integer  "place_id"
    t.integer  "status"
    t.string   "place_title"
    t.string   "service_type_title"
    t.string   "vendor_title"
    t.string   "tariff_title"
    t.float    "amount"
  end

  create_table "analytic_queries", :force => true do |t|
    t.string "title"
    t.text   "query"
  end

  create_table "analytics", :force => true do |t|
    t.float    "amount"
    t.integer  "place_id"
    t.integer  "service_id"
    t.string   "place_title"
    t.string   "service_title"
    t.string   "tariff_title"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.integer  "user_id"
  end

  create_table "cards", :force => true do |t|
    t.integer  "user_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.string   "card_title"
    t.string   "rebill_anchor"
  end

  create_table "category", :id => false, :force => true do |t|
    t.integer "id",                                :null => false
    t.integer "parent_category_id"
    t.string  "name",               :limit => 100, :null => false
  end

  create_table "cities", :force => true do |t|
    t.string "title"
  end

  create_table "emergency_categories", :force => true do |t|
    t.string "title"
  end

  create_table "emergency_infos", :force => true do |t|
    t.string  "title"
    t.string  "description"
    t.integer "emergency_service_id"
    t.string  "phone"
  end

  create_table "emergency_services", :force => true do |t|
    t.string  "title"
    t.integer "emergency_category_id"
  end

  create_table "field_list_values", :force => true do |t|
    t.integer  "field_id"
    t.float    "value"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "field_template_list_values", :force => true do |t|
    t.integer  "field_template_id"
    t.float    "value"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

  create_table "field_templates", :force => true do |t|
    t.string   "title"
    t.integer  "tariff_template_id"
    t.string   "field_type"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
    t.boolean  "is_for_calc"
    t.float    "value"
    t.string   "reading_field_title"
    t.string   "field_units"
  end

  create_table "fields", :force => true do |t|
    t.string   "title"
    t.string   "field_type"
    t.boolean  "is_for_calc"
    t.float    "value"
    t.string   "reading_field_title"
    t.integer  "tariff_id"
    t.integer  "field_template_id"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
    t.string   "field_units"
  end

  create_table "freelance_categories", :force => true do |t|
    t.string   "title"
    t.string   "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "freelance_interface_comments", :force => true do |t|
    t.text     "body"
    t.float    "raiting"
    t.boolean  "published"
    t.integer  "freelancer_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.integer  "user_id"
  end

  create_table "freelance_interface_freelancer_tags", :force => true do |t|
    t.integer  "tag_id"
    t.integer  "freelancer_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "freelance_interface_freelancers", :force => true do |t|
    t.string   "name"
    t.string   "surname"
    t.string   "phone_number"
    t.string   "picture_url"
    t.text     "description"
    t.float    "raiting"
    t.boolean  "published"
    t.date     "unpublish_at"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.integer  "user_id"
    t.integer  "service_id"
    t.integer  "number_of_month"
    t.integer  "recipe_id"
  end

  create_table "freelance_interface_tags", :force => true do |t|
    t.string   "title"
    t.float    "weight"
    t.boolean  "published"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "freelance_interface_top_four_freelancers", :force => true do |t|
    t.integer  "freelancer_id"
    t.integer  "tag_id"
    t.date     "unpublish_at"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.integer  "number_of_month"
    t.integer  "recipe_id"
  end

  create_table "freelance_interface_top_ten_freelancers", :force => true do |t|
    t.integer  "freelancer_id"
    t.date     "unpublish_at"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.integer  "number_of_month"
    t.integer  "recipe_id"
  end

  create_table "freelancers", :force => true do |t|
    t.string   "title"
    t.string   "phone"
    t.string   "work_time"
    t.text     "description"
    t.string   "picture_url"
    t.integer  "freelance_category_id"
    t.datetime "created_at",            :null => false
    t.datetime "updated_at",            :null => false
    t.string   "name"
    t.boolean  "published"
  end

  create_table "meter_readings", :force => true do |t|
    t.float    "reading"
    t.integer  "user_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.boolean  "is_init"
    t.string   "snapshot_url"
    t.integer  "service_id"
    t.integer  "field_id"
  end

  create_table "non_utility_served_cities", :force => true do |t|
    t.integer "non_utility_vendor_id"
    t.integer "city_id"
  end

  create_table "non_utility_service_types", :force => true do |t|
    t.string   "title"
    t.string   "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "non_utility_tariffs", :force => true do |t|
    t.string   "title"
    t.string   "description"
    t.integer  "non_utility_vendor_id"
    t.datetime "created_at",            :null => false
    t.datetime "updated_at",            :null => false
  end

  create_table "non_utility_vendor_map_positions", :force => true do |t|
    t.string   "title"
    t.string   "latitude"
    t.string   "longitude"
    t.integer  "non_utility_vendor_id"
    t.datetime "created_at",            :null => false
    t.datetime "updated_at",            :null => false
  end

  create_table "non_utility_vendors", :force => true do |t|
    t.string   "title"
    t.string   "description"
    t.string   "phone"
    t.string   "work_time"
    t.string   "address"
    t.integer  "non_utility_service_type_id"
    t.datetime "created_at",                  :null => false
    t.datetime "updated_at",                  :null => false
    t.string   "picture_url"
  end

  create_table "payment_histories", :force => true do |t|
    t.integer  "user_id"
    t.integer  "card_id"
    t.float    "amount"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
    t.datetime "po_date_time"
    t.integer  "po_transaction_id"
    t.integer  "recipe_id"
    t.string   "currency"
    t.string   "card_holder"
    t.string   "card_number"
    t.string   "country"
    t.string   "city"
    t.string   "eci"
    t.string   "payment_type"
    t.integer  "status"
    t.integer  "service_id"
  end

  create_table "place_types", :force => true do |t|
    t.string   "title"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "places", :force => true do |t|
    t.integer  "user_id"
    t.string   "title"
    t.string   "city"
    t.string   "street"
    t.string   "building"
    t.string   "apartment"
    t.boolean  "is_active"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "city_id"
    t.integer  "type_id"
  end

  create_table "precinct_houses", :force => true do |t|
    t.integer "precinct_street_id"
    t.integer "precinct_id"
    t.string  "house"
  end

  create_table "precinct_streets", :force => true do |t|
    t.string "street"
  end

  create_table "precincts", :force => true do |t|
    t.string   "ovd"
    t.string   "ovd_town"
    t.string   "ovd_street"
    t.string   "ovd_house"
    t.string   "ovd_telnumber"
    t.string   "surname"
    t.string   "middlename"
    t.string   "name"
    t.string   "photo_url"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "quiz_answers", :force => true do |t|
    t.integer "quiz_question_id"
    t.string  "body"
  end

  create_table "quiz_questions", :force => true do |t|
    t.string  "body"
    t.boolean "has_custom"
  end

  create_table "quiz_results", :force => true do |t|
    t.integer  "user_id"
    t.integer  "quiz_question_id"
    t.integer  "quiz_answer_id"
    t.string   "custom_answer"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  create_table "quiz_sessions", :force => true do |t|
    t.integer  "user_id"
    t.string   "quiz_token"
    t.integer  "last_question_id"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  create_table "reading_field_templates", :force => true do |t|
    t.string   "title"
    t.integer  "field_template_id"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

  create_table "recipes", :force => true do |t|
    t.float    "amount"
    t.float    "total"
    t.float    "po_tax"
    t.float    "service_tax"
    t.string   "currency"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.integer  "service_id"
    t.integer  "user_id"
    t.integer  "account_id"
  end

  create_table "revisions", :force => true do |t|
    t.integer  "revision"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "served_cities", :force => true do |t|
    t.integer "vendor_id"
    t.integer "city_id"
  end

  create_table "service_types", :force => true do |t|
    t.string   "title"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "services", :force => true do |t|
    t.string   "title"
    t.integer  "user_id"
    t.integer  "tariff_id"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.integer  "place_id"
    t.integer  "service_type_id"
    t.integer  "vendor_id"
    t.string   "user_account"
    t.boolean  "is_active"
  end

  create_table "tariff_templates", :force => true do |t|
    t.string   "title"
    t.integer  "service_type_id"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.boolean  "has_readings"
    t.integer  "vendor_id"
  end

  create_table "tariffs", :force => true do |t|
    t.string   "title"
    t.integer  "tariff_template_id"
    t.integer  "owner_id"
    t.string   "owner_type"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
    t.boolean  "has_readings"
    t.integer  "service_type_id"
    t.integer  "service_id"
  end

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "authentication_token"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.string   "first_name"
    t.string   "phone_number"
    t.string   "ios_device_token"
    t.string   "ios_device_status"
    t.boolean  "admin"
  end

  add_index "users", ["authentication_token"], :name => "index_users_on_authentication_token", :unique => true
  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  create_table "utility_metric_settings", :force => true do |t|
    t.integer  "user_id"
    t.boolean  "water_cold"
    t.boolean  "water_hot"
    t.boolean  "energy_phase_one"
    t.boolean  "energy_phase_two"
    t.string   "address"
    t.integer  "vendor_id"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
    t.boolean  "energy_phase_common"
  end

  create_table "utility_metrics", :force => true do |t|
    t.integer  "user_id"
    t.integer  "vendor_id"
    t.float    "water_hot"
    t.float    "water_cold"
    t.float    "energy_phase_one"
    t.float    "energy_phase_two"
    t.float    "gas"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
    t.boolean  "processed"
    t.float    "energy_phase_common"
  end

  create_table "values", :force => true do |t|
    t.integer  "tariff_id"
    t.integer  "field_template_id"
    t.string   "value"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
    t.integer  "field_id"
  end

  create_table "vendors", :force => true do |t|
    t.string   "title"
    t.integer  "service_type_id"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.integer  "merchant_id"
    t.boolean  "is_active"
    t.string   "psk"
    t.float    "commission"
    t.boolean  "is_integrated"
    t.string   "inn"
  end

  create_table "web_interface_news_items", :force => true do |t|
    t.string   "title"
    t.text     "body"
    t.string   "date"
    t.boolean  "published"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.boolean  "is_company"
  end

end
