class AddDifficultyToQuizWadokaichin < ActiveRecord::Migration[6.0]
  def change
    add_column :quiz_wadokaichins, :difficulty, :integer
  end
end
