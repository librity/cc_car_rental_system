# frozen_string_literal: true

# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20_200_423_022_923) do
  create_table 'car_categories', force: :cascade do |t|
    t.string 'name'
    t.float 'daily_rate'
    t.float 'insurance'
    t.float 'third_party_insurance'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.index ['name'], name: 'index_car_categories_on_name', unique: true
  end

  create_table 'car_models', force: :cascade do |t|
    t.string 'name'
    t.integer 'year'
    t.string 'metric_horsepower'
    t.string 'fuel_type'
    t.integer 'metric_city_milage'
    t.integer 'metric_highway_milage'
    t.integer 'car_category_id', null: false
    t.integer 'manufacturer_id', null: false
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.string 'engine'
    t.index ['car_category_id'], name: 'index_car_models_on_car_category_id'
    t.index ['manufacturer_id'], name: 'index_car_models_on_manufacturer_id'
  end

  create_table 'customers', force: :cascade do |t|
    t.string 'name'
    t.string 'cpf'
    t.string 'email'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.index ['cpf'], name: 'index_customers_on_cpf', unique: true
    t.index ['email'], name: 'index_customers_on_email', unique: true
  end

  create_table 'manufacturers', force: :cascade do |t|
    t.string 'name'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.index ['name'], name: 'index_manufacturers_on_name', unique: true
  end

  create_table 'subsidiaries', force: :cascade do |t|
    t.string 'name'
    t.string 'cnpj'
    t.string 'address'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.index ['cnpj'], name: 'index_subsidiaries_on_cnpj', unique: true
    t.index ['name'], name: 'index_subsidiaries_on_name', unique: true
  end

  add_foreign_key 'car_models', 'car_categories'
  add_foreign_key 'car_models', 'manufacturers'
end
