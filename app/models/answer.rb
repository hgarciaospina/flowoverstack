# == Schema Information
#
# Table name: answers
#
#  id          :integer          not null, primary key
#  body        :string           not null
#  user_id     :integer          not null
#  question_id :integer          not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Answer < ActiveRecord::Base
  belongs_to :user
  belongs_to :question
  has_many :votes, as: :votable
  has_many :comments, as: :commentable

  validates :body, presence: true

  scope :order_by_ranking, -> { order("votes.id") }
end
