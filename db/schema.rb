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

ActiveRecord::Schema.define(version: 20161201174533) do

  create_table "artists", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "artists_users", force: :cascade do |t|
    t.integer "artist_id"
    t.integer "user_id"
    t.index ["artist_id"], name: "index_artists_users_on_artist_id"
    t.index ["user_id"], name: "index_artists_users_on_user_id"
  end

  create_table "concerts", force: :cascade do |t|
    t.string   "name"
    t.datetime "date"
    t.string   "url"
    t.string   "genre"
    t.string   "subgenre"
    t.boolean  "sale"
    t.string   "image"
    t.string   "lat"
    t.string   "lon"
    t.string   "city"
    t.string   "venue"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "concert_id"
    t.string   "country"
  end

  create_table "concerts_users", force: :cascade do |t|
    t.integer "user_id"
    t.integer "concert_id"
    t.index ["concert_id"], name: "index_concerts_users_on_concert_id"
    t.index ["user_id"], name: "index_concerts_users_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "password_digest"
    t.string   "token"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "email"
    t.index ["email"], name: "index_users_on_email", unique: true
  end

end
