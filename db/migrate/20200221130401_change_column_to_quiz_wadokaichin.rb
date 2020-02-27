class ChangeColumnToQuizWadokaichin < ActiveRecord::Migration[6.0]
  def change
    rename_column :quiz_wadokaichins, :jukugo_down_name, :jukugo_bottom_name
    rename_column :quiz_wadokaichins, :jukugo_up_name, :jukugo_top_name
    rename_column :quiz_wadokaichin_jukugos, :jukugo_down_id, :jukugo_bottom_id
    rename_column :quiz_wadokaichin_jukugos, :jukugo_up_id, :jukugo_top_id
  end
end
