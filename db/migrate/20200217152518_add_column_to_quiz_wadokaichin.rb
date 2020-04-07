# frozen_string_literal: true

class AddColumnToQuizWadokaichin < ActiveRecord::Migration[6.0]
  def change
    add_column :quiz_wadokaichins, :jukugo1_name, :string
    add_column :quiz_wadokaichins, :jukugo2_name, :string
    add_column :quiz_wadokaichins, :jukugo3_name, :string
    add_column :quiz_wadokaichins, :jukugo4_name, :string
  end
end
