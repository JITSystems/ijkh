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

ActiveRecord::Schema.define(:version => 20130711071144) do

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

  create_table "freelancers", :force => true do |t|
    t.string   "title"
    t.string   "phone"
    t.string   "work_time"
    t.string   "description"
    t.string   "picture_url"
    t.integer  "freelance_category_id"
    t.datetime "created_at",            :null => false
    t.datetime "updated_at",            :null => false
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
  end

  add_index "users", ["authentication_token"], :name => "index_users_on_authentication_token", :unique => true
  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

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
  end

end
