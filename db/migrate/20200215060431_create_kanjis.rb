class CreateKanjis < ActiveRecord::Migration[6.0]
  def change
    create_table :kanjis do |t|
      t.string :character
      t.integer :jis
      t.integer :joyo
      t.integer :kanken
      t.integer :primary_school

      t.timestamps
    end
  end
end
