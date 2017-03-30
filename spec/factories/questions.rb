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

FactoryGirl.define do
  factory :question do
    association :user
    title { Faker::Hipster.sentence(3) }
    body { Faker::Lorem.characters(600) }

    factory :invalid_question do
      title nil
    end 
  end
end
