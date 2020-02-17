class CreateJukugos < ActiveRecord::Migration[6.0]
  def change
    create_table :jukugos do |t|
      t.string :name, unique: true, limit: 2
      t.string :reading
      t.text :meaning

      t.timestamps
    end
  end
end
