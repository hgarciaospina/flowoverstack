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

class VotesController < ApplicationController
  before_action :private_access!

  def create
    votable_type = params[:votable_type]
    votable_id = "#{votable_type.downcase}_id".to_s

    @votable = votable_type.constantize.find(params[votable_id])
    @votable.votes.create(user: current_user) unless current_user.voted(@votable)

    redirect_to question_path
  end

  def destroy
    votable_type = params[:votable_type]
    votable_id = "#{votable_type.downcase}_id".to_s

    @vote = current_user.votes.find_by_votable_type_and_votable_id(votable_type, params[votable_id])
    @votable = @vote.votable

    @vote.try(:destroy)

    redirect_to question_path
  end

  private

    def question_path
      @votable.respond_to?(:question) ? @votable.question : @votable
    end
end
