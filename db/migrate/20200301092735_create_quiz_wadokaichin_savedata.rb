class CreateQuizWadokaichinSavedata < ActiveRecord::Migration[6.0]
  def change
    create_table :quiz_wadokaichin_savedata do |t|
      t.integer :user_id
      t.integer :quiz_wadokaichin_id

      t.timestamps
    end
    add_index :quiz_wadokaichin_savedata, [:user_id, :quiz_wadokaichin_id],
              unique: true, name: 'quiz_wadokaichin_savedata_index'
  end
end
