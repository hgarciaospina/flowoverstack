# == Schema Information
#
# Table name: questions
#
#  id         :integer          not null, primary key
#  title      :string           not null
#  body       :text             not null
#  user_id    :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Question < ActiveRecord::Base
  belongs_to :user
  has_many :votes, as: :votable
  has_many :answers
  has_many :comments, as: :commentable

  validates :title, presence: true
  validates :body, presence: true
end
