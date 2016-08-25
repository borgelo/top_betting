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

ActiveRecord::Schema.define(version: 20160825172247) do

  create_table "Bets", force: true do |t|
    t.integer  "user_id"
    t.integer  "league_id"
    t.integer  "position"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "seasonstartyear"
  end

  add_index "Bets", ["league_id"], name: "index_bets_on_league_id"
  add_index "Bets", ["user_id"], name: "index_bets_on_user_id"

  create_table "Leagues", force: true do |t|
    t.string   "name"
    t.integer  "position"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "played"
    t.integer  "win"
    t.integer  "drawn"
    t.integer  "lost"
    t.integer  "against"
    t.integer  "goal_difference"
    t.integer  "points"
    t.integer  "for"
    t.integer  "seasonstartyear"
  end

  create_table "users", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
