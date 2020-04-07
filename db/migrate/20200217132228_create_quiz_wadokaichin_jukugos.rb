# frozen_string_literal: true

class CreateQuizWadokaichinJukugos < ActiveRecord::Migration[6.0]
  def change
    create_table :quiz_wadokaichin_jukugos do |t|
      t.integer :quiz_wadokaichin_id
      t.integer :jukugo1_id
      t.integer :jukugo2_id
      t.integer :jukugo3_id
      t.integer :jukugo4_id

      t.timestamps
    end
  end
end
