# == Schema Information
#
# Table name: evaluations
#
#  id          :integer          not null, primary key
#  words_read  :integer
#  user_id     :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  phrase_read :integer
#

class Evaluation < ActiveRecord::Base
  belongs_to :user
end
