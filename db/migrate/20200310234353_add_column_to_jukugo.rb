# frozen_string_literal: true

class AddColumnToJukugo < ActiveRecord::Migration[6.0]
  def change
    add_column :jukugos, :example, :integer
  end
end
