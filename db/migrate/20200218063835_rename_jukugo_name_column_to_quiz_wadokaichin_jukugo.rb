# frozen_string_literal: true

class RenameJukugoNameColumnToQuizWadokaichinJukugo < ActiveRecord::Migration[6.0]
  def change
    rename_column :quiz_wadokaichins, :jukugo1_name, :jukugo_right_name
    rename_column :quiz_wadokaichins, :jukugo2_name, :jukugo_down_name
    rename_column :quiz_wadokaichins, :jukugo3_name, :jukugo_left_name
    rename_column :quiz_wadokaichins, :jukugo4_name, :jukugo_up_name

    rename_column :quiz_wadokaichin_jukugos, :jukugo1_id, :jukugo_right_id
    rename_column :quiz_wadokaichin_jukugos, :jukugo2_id, :jukugo_down_id
    rename_column :quiz_wadokaichin_jukugos, :jukugo3_id, :jukugo_left_id
    rename_column :quiz_wadokaichin_jukugos, :jukugo4_id, :jukugo_up_id
  end
end
