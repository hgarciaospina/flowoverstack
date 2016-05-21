# == Schema Information
#
# Table name: votes
#
#  id           :integer          not null, primary key
#  votable_id   :integer          not null
#  votable_type :string           not null
#  user_id      :integer          not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

FactoryGirl.define do
  factory :vote do
    association :user

    factory :question_vote do
      association :votable, factory: :question
    end

    factory :answer_vote do
      association :votable, factory: :answer
    end
  end
end
