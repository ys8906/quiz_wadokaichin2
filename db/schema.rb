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

ActiveRecord::Schema.define(version: 20_200_311_011_546) do
  create_table 'jukugos', options: 'ENGINE=InnoDB DEFAULT CHARSET=utf8mb4', force: :cascade do |t|
    t.string 'name', limit: 2
    t.string 'reading'
    t.text 'meaning'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.integer 'example'
  end

  create_table 'kanjis', options: 'ENGINE=InnoDB DEFAULT CHARSET=utf8mb4', force: :cascade do |t|
    t.string 'character', limit: 1
    t.integer 'jis'
    t.integer 'joyo'
    t.integer 'kanken'
    t.integer 'primary_school'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
  end

  create_table 'quiz_wadokaichin_jukugos', options: 'ENGINE=InnoDB DEFAULT CHARSET=utf8mb4', force: :cascade do |t|
    t.integer 'quiz_wadokaichin_id'
    t.integer 'jukugo_right_id'
    t.integer 'jukugo_bottom_id'
    t.integer 'jukugo_left_id'
    t.integer 'jukugo_top_id'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
  end

  create_table 'quiz_wadokaichin_reactions', options: 'ENGINE=InnoDB DEFAULT CHARSET=utf8mb4', force: :cascade do |t|
    t.integer 'quiz_wadokaichin_id'
    t.string 'remote_ip'
    t.integer 'rating', default: 0, null: false
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.index %w[quiz_wadokaichin_id remote_ip], name: 'quiz_wadokaichin_reactions_index', unique: true
  end

  create_table 'quiz_wadokaichin_savedata', options: 'ENGINE=InnoDB DEFAULT CHARSET=utf8mb4', force: :cascade do |t|
    t.integer 'user_id'
    t.integer 'quiz_wadokaichin_id'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.integer 'correct', default: 0, null: false
    t.index %w[user_id quiz_wadokaichin_id], name: 'quiz_wadokaichin_savedata_index', unique: true
  end

  create_table 'quiz_wadokaichins', options: 'ENGINE=InnoDB DEFAULT CHARSET=utf8mb4', force: :cascade do |t|
    t.string 'answer'
    t.string 'image_url'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.string 'jukugo_right_name'
    t.string 'jukugo_bottom_name'
    t.string 'jukugo_left_name'
    t.string 'jukugo_top_name'
    t.integer 'difficulty'
  end

  create_table 'users', options: 'ENGINE=InnoDB DEFAULT CHARSET=utf8mb4', force: :cascade do |t|
    t.string 'name'
    t.string 'email', default: '', null: false
    t.string 'encrypted_password', default: '', null: false
    t.string 'reset_password_token'
    t.datetime 'reset_password_sent_at'
    t.datetime 'remember_created_at'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.string 'provider'
    t.string 'uid'
    t.index ['email'], name: 'index_users_on_email', unique: true
    t.index ['reset_password_token'], name: 'index_users_on_reset_password_token', unique: true
  end
end
