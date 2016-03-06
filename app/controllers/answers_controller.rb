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

class AnswersController < ApplicationController
  before_action :private_access!

  def create
    question = Question.find(params[:question_id])
    question.answers.create(answer_params)

    redirect_to question
  end

  private

    def answer_params
      params.require(:answer).permit(:body).merge(user: current_user)
    end
end
