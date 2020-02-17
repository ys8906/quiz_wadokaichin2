class CreateQuizWadokaichins < ActiveRecord::Migration[6.0]
  def change
    create_table :quiz_wadokaichins do |t|
      t.string :answer
      t.string :image

      t.timestamps
    end
  end
end
