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

class QuestionsController < ApplicationController
  before_action :private_access!, except: [:index, :show]
  before_action :set_question, except: [:index, :new, :create]
  before_action :access_only_your_questions!, only: [:edit, :update, :destroy]

  def index
    if params[:q]
      @questions = Question.includes(:votes, :answers).where('title ILIKE ?', "%#{params[:q]}%")
    else
      @questions = Question.includes(:votes, :answers).limit(10).order(created_at: :desc)
    end
  end

  def show
    @question_votes = @question.votes
    @question_answers = @question.answers.order_by_ranking.includes(:comments, :votes)
    @question_comments = @question.comments.order(:created_at)
  end

  def new
    @question = Question.new
  end

  def edit
  end

  def create
    @question = current_user.questions.new(question_params)

    if @question.save
      redirect_to @question, notice: 'Pregunta publicada.'
    else
      render :new
    end
  end

  def update
    if @question.update(question_params)
      redirect_to @question, notice: 'Pregunta actulizada.'
    else
      render :edit
    end
  end

  def destroy
    @question.destroy
    redirect_to questions_url, notice: 'Pregunta retirada.'
  end

  private

    def set_question
      @question = Question.find(params[:id])
    end

    def access_only_your_questions!
      redirect_to questions_path, alert: 'No tienes permisos.' unless @question.belong_user(current_user)
    end

    def question_params
      params.require(:question).permit(:title, :body)
    end
end
