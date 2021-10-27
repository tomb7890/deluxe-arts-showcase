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

ActiveRecord::Schema.define(version: 2021_10_27_104227) do

  create_table "artists", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.string "image"
    t.string "website"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "artists_genres", id: false, force: :cascade do |t|
    t.integer "artist_id", null: false
    t.integer "genre_id", null: false
    t.index ["artist_id", "genre_id"], name: "index_artists_genres_on_artist_id_and_genre_id"
    t.index ["genre_id", "artist_id"], name: "index_artists_genres_on_genre_id_and_artist_id"
  end

  create_table "genres", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

end
