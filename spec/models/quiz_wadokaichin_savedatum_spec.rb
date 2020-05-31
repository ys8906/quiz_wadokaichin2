# frozen_string_literal: true

# == Schema Information
#
# Table name: quiz_wadokaichin_savedata
#
#  id                  :bigint           not null, primary key
#  user_id             :integer
#  quiz_wadokaichin_id :integer
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  correct             :integer          default(0), not null
#
require 'rails_helper'

RSpec.describe QuizWadokaichinSavedatum, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
