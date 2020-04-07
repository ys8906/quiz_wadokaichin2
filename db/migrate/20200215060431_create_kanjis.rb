# frozen_string_literal: true

class CreateKanjis < ActiveRecord::Migration[6.0]
  def change
    create_table :kanjis do |t|
      t.string :character, unique: true, limit: 1
      t.integer :jis
      t.integer :joyo
      t.integer :kanken
      t.integer :primary_school

      t.timestamps
    end
  end
end
