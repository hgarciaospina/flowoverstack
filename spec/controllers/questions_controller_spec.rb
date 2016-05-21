require 'rails_helper'

describe QuestionsController do
  let(:user) { create(:user) }

  let(:question) { create(:question, user: user) }
  let(:valid_question) { attributes_for(:question) }
  let(:invalid_question) { attributes_for(:invalid_question) }

  shared_examples 'full access to questions' do
    describe 'GET #new' do
      it 'assigns a new Question to @question' do
        get :new
        expect(assigns(:question)).to be_a_new(Question)
      end

      it 'renders the :new template' do
        get :new
        expect(response).to render_template :new
      end
    end

    describe 'GET #edit' do
      it 'assigns the requested question to @question' do
        get :edit, id: question
        expect(assigns(:question)).to eq question
      end

      it 'renders the :edit template' do
        get :edit, id: question
        expect(response).to render_template :edit
      end
    end

    describe 'POST #create' do
      context 'with valid attributes' do
        it 'saves the new question in the database' do
          expect{
            post :create, question: valid_question
          }.to change(Question, :count).by(1)
        end

        it 'redirect to questions#show' do
          post :create, question: valid_question
          expect(response).to redirect_to question_path(assigns[:question])
        end
      end

      context 'with invalid attributes' do
        it 'does not save the new question in the database' do
          expect{
            post :create, question: invalid_question
          }.not_to change(Question, :count)
        end

        it 're-renders the :new template' do
          post :create, question: invalid_question
          expect(response).to render_template :new
        end
      end
    end

    describe 'PATCH #update' do
      context 'with valid attributes' do
        it 'locates the requested @question' do
          patch :update, id: question, question: valid_question
          expect(assigns(:question)).to eq(question)
        end

        it 'changes questions attributes' do
          patch :update, id: question, question: attributes_for(:question, title: 'Why is processing a sorted array faster than an unsorted array?')
          question.reload

          expect(question.title).to eq 'Why is processing a sorted array faster than an unsorted array?'
        end

        it 'redirects to the upload question' do
          patch :update, id: question, question: valid_question
          expect(response).to redirect_to question
        end
      end

      context 'with invalid attributes' do
        it 'does not change the questions attributes' do
          patch :update, id: question, question: invalid_question
          question.reload

          expect(question.title).not_to eq nil
        end

        it 're-renders the :edit template' do
          patch :update, id: question, question: invalid_question
          expect(response).to render_template :edit
        end
      end
    end

    describe 'DELETE #destroy' do
      it "deletes the question" do
        question
        expect{
        delete :destroy, id: question
        }.to change(Question,:count).by(-1)
      end

      it 'redirects to questions#index' do
        delete :destroy, id: question
        expect(response).to redirect_to questions_url
      end
    end
  end

  describe 'user access' do
    before :each do
      allow(controller).to receive(:current_user).and_return(user)
    end

    it_behaves_like 'full access to questions'
  end
end