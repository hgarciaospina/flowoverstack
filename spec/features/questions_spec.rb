require 'rails_helper'

feature 'Question management' do
  let(:user) { create(:user) }
  let(:question) { create(:question, user: user) }

  context "as a user" do
    scenario 'adds a new question' do
      login(user)

      expect{
        click_link 'Hacer una pregunta'
        fill_in 'question_title', with: 'Esto es una pregunta'
        fill_in 'question_body', with: 'Esto es el cuerpo de la pregunta'
        click_button 'Publicar'
      }.to change(Question, :count).by(1)

      question_last = Question.last

      expect(current_path).to eq question_path(question_last)
      expect(page).to have_content 'Pregunta publicada.'
      within 'h1' do
        expect(page).to have_content question_last.title
      end
    end

    scenario 'adds a new comment to a question' do
      question

      login(user)

      expect{
        click_link question.title
        fill_in 'comment_body', with: 'Esto es un comentario'
        click_button 'Comentar'
      }.to change(Comment, :count).by(1)

      question_comment_last = question.comments.last

      expect(current_path).to eq question_path(question)

      within '.comment' do
        expect(page).to have_content question_comment_last.body
      end

      within 'h1' do
        expect(page).to have_content question.title
      end
    end
  end
end