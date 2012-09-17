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

ActiveRecord::Schema.define(:version => 20120916161715) do

  create_table "contestants", :force => true do |t|
    t.string   "name"
    t.integer  "round"
    t.boolean  "survive"
    t.boolean  "immunity"
    t.boolean  "merger"
    t.boolean  "final_three"
    t.boolean  "winner"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.string   "nickname"
    t.string   "tribe"
    t.integer  "age"
    t.string   "hometown"
    t.string   "occupation"
    t.integer  "preseason_rank"
    t.string   "labwork"
  end

  create_table "leagues", :force => true do |t|
    t.string   "name"
    t.string   "confirmation_code"
    t.text     "contestant_pool"
    t.text     "scoring_system"
    t.datetime "created_at",                           :null => false
    t.datetime "updated_at",                           :null => false
    t.text     "draft_order"
    t.boolean  "draft_active",      :default => false
    t.integer  "draft_round",       :default => 0
    t.boolean  "draft_start",       :default => false
    t.integer  "teamsize",          :default => 1
  end

  create_table "users", :force => true do |t|
    t.string   "username"
    t.string   "password_digest"
    t.string   "email"
    t.integer  "league_id"
    t.text     "team"
    t.boolean  "lc",                     :default => false
    t.datetime "created_at",                                :null => false
    t.datetime "updated_at",                                :null => false
    t.datetime "last_seen"
    t.boolean  "first_visit",            :default => true
    t.string   "password_reset_token"
    t.datetime "password_reset_sent_at"
    t.string   "first_name"
    t.string   "last_name"
    t.integer  "score_round1",           :default => 0
    t.integer  "score_round2",           :default => 0
    t.integer  "score_round3",           :default => 0
    t.integer  "score_round4",           :default => 0
    t.integer  "score_round5",           :default => 0
    t.integer  "score_round6",           :default => 0
    t.integer  "score_round7",           :default => 0
    t.integer  "score_round8",           :default => 0
    t.integer  "score_round9",           :default => 0
    t.integer  "score_round10",          :default => 0
    t.integer  "score_round11",          :default => 0
    t.integer  "score_round12",          :default => 0
    t.integer  "score_round13",          :default => 0
    t.integer  "score_round14",          :default => 0
    t.integer  "score_round15",          :default => 0
    t.integer  "score_round16",          :default => 0
    t.integer  "score_round17",          :default => 0
    t.integer  "score_round18",          :default => 0
    t.integer  "score_round19",          :default => 0
    t.integer  "score_round20",          :default => 0
    t.integer  "score_round21",          :default => 0
    t.integer  "score_round22",          :default => 0
    t.integer  "score_round23",          :default => 0
    t.integer  "score_round24",          :default => 0
    t.integer  "score_round25",          :default => 0
    t.integer  "score_round26",          :default => 0
    t.integer  "score_round27",          :default => 0
    t.integer  "score_round28",          :default => 0
    t.integer  "score_round29",          :default => 0
    t.integer  "score_round30",          :default => 0
  end

end
