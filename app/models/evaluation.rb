# == Schema Information
#
# Table name: evaluations
#
#  id          :integer          not null, primary key
#  words_read  :integer
#  total_words :integer
#  user_id     :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Evaluation < ActiveRecord::Base
  belongs_to :user
  validates :words_read, presence: true
end
