class CreateQuizWadokaichinReactions < ActiveRecord::Migration[6.0]
  def change
    create_table :quiz_wadokaichin_reactions do |t|
      t.integer :quiz_wadokaichin_id
      t.string :remote_ip
      t.integer :rating

      t.timestamps
    end
    add_index :quiz_wadokaichin_reactions, [:quiz_wadokaichin_id, :remote_ip],
              unique: true, name: 'quiz_wadokaichin_reactions_index'
  end
end
