# frozen_string_literal: true

class ChangeColumnImageToQuizWadokaichin < ActiveRecord::Migration[6.0]
  def change
    rename_column :quiz_wadokaichins, :image, :image_url
  end
end
