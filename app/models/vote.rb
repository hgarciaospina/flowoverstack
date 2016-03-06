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

class Vote < ActiveRecord::Base
  belongs_to :votable, polymorphic: true
  belongs_to :user
end
