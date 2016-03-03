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

class CommentsController < ApplicationController
  before_action :private_access!

  def create
    commentable_type = params[:commentable_type]
    commentable_id = "#{commentable_type.downcase}_id".to_s

    @commentable = commentable_type.constantize.find(params[commentable_id])
    @commentable.comments.create(comment_params)

    redirect_to question_path
  end

  private

    def question_path
      @commentable.respond_to?(:question) ? @commentable.question : @commentable
    end

    def comment_params
      params.require(:comment).permit(:body).merge(user: current_user)
    end
end
