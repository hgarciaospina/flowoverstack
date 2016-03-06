# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  email           :string           not null
#  password_digest :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class User < ActiveRecord::Base
  has_secure_password validations: false

  has_many :questions
  has_many :votes

  validates :email, uniqueness: true, format: /@/
  validates :password, presence: true, on: :create
  validates :password, length: { in: 6..20 }, allow_nil: true

  def voted(votable)
    self.votes.find_by_votable_type_and_votable_id(votable.class.name, votable.id)
  end
end
