# == Schema Information
#
# Table name: comments
#
#  id               :integer          not null, primary key
#  body             :text             not null
#  commentable_id   :integer          not null
#  commentable_type :string           not null
#  user_id          :integer          not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

FactoryGirl.define do
  factory :comment do
    association :user
    body { Faker::Lorem.paragraph }

    factory :question_comment do
      association :commentable, factory: :question
    end

    factory :answer_comment do
      association :commentable, factory: :answer
    end
  end
end
