class AddColumnToQuizWadokaichinSavedatum < ActiveRecord::Migration[6.0]
  def change
    add_column :quiz_wadokaichin_savedata, :correct, :integer
  end
end
