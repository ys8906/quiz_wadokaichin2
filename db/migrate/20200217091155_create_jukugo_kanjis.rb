class CreateJukugoKanjis < ActiveRecord::Migration[6.0]
  def change
    create_table :jukugo_kanjis do |t|
      t.integer :jukugo_id
      t.integer :kanji1_id
      t.integer :kanji2_id

      t.timestamps
    end
  end
end
