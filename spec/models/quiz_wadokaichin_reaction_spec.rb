# frozen_string_literal: true

# == Schema Information
#
# Table name: quiz_wadokaichin_reactions
#
#  id                  :bigint           not null, primary key
#  quiz_wadokaichin_id :integer
#  remote_ip           :string(255)
#  rating              :integer          default(0), not null
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#
require 'rails_helper'

RSpec.describe QuizWadokaichinReaction, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
