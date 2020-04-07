# frozen_string_literal: true

class ChangeColumnToQuizWadokaichinSavedatum < ActiveRecord::Migration[6.0]
  def change
    change_column :quiz_wadokaichin_reactions, :rating, :integer, null: false, default: 0
    change_column :quiz_wadokaichin_savedata, :correct, :integer, null: false, default: 0
  end
end
