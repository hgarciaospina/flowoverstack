require 'rails_helper'

describe QuestionsController do
  let(:user) { create(:user) }
  let(:user_random) { create(:user) }

  let(:question) { create(:question, user: user) }
  let(:question_random) { create(:question, user: user_random) }
  let(:valid_question) { attributes_for(:question) }
  let(:invalid_question) { attributes_for(:invalid_question) }

  shared_examples 'guest access to questions' do
    describe 'GET #index' do
      context 'with params[:q]' do
        it 'populates an array of questions filtered by query' do
          question_ruby = create(:question, user: user, title: 'ruby')
          question_js = create(:question, user: user, title: 'js')

          get :index, q: 'ruby'
          expect(assigns(:questions)).to eq([question_ruby])
        end
      end

      context 'without params[:q]' do
        before :each do
          12.times { create(:question, user: user) }
        end

        it 'populates an array with questions' do
          get :index
          expect(assigns(:questions).size).to eq(10)
        end
      end
    end

    describe 'GET #show' do
      it 'assign the requested question to @question' do
        get :show, id: question
        expect(assigns(:question)).to eq(question)
      end

      it 'assign the requested question votes to @question_votes' do
        get :show, id: question
        expect(assigns(:question_votes)).to eq(question.votes)
      end

      it 'assign the requested question answers to @question_answers' do
        get :show, id: question
        expect(assigns(:question_answers)).to eq(question.answers)
      end

      it 'assign the requested question comments to @question_comments' do
        get :show, id: question
        expect(assigns(:question_comments)).to eq(question.comments)
      end

      it 'renders the :show template' do
        get :show, id: question
        expect(response).to render_template :show
      end
    end
  end

  describe 'user access' do
    before :each do
      allow(controller).to receive(:current_user).and_return(user)
    end

    it_behaves_like 'guest access to questions'

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

    context 'Question from another user' do
      describe 'GET #edit' do
        it 'requires permission' do
          get :edit, id: question_random
          expect(response).to require_permission
        end
      end

      describe 'PATCH #update' do
        it 'requires permission' do
          patch :update, id: question_random, question: valid_question
          expect(response).to require_permission
        end
      end

      describe 'DELETE #destroy' do
        it 'requires permission' do
          delete :destroy, id: question_random
          expect(response).to require_permission
        end
      end
    end
  end

  describe 'guest access' do
    it_behaves_like 'guest access to questions'

    describe 'GET #new' do
      it 'requires login' do
        get :new
        expect(response).to require_login
      end
    end

    describe 'GET #edit' do
      it 'requires login' do
        get :edit, id: question
        expect(response).to require_login
      end
    end

    describe 'POST #create' do
      it 'requires login' do
        post :create, question: valid_question
        expect(response).to require_login
      end
    end

    describe 'PATCH #update' do
      it 'requires login' do
        patch :update, id: question, question: valid_question
        expect(response).to require_login
      end
    end

    describe 'DELETE #destroy' do
      it 'requires login' do
        delete :destroy, id: question
        expect(response).to require_login
      end
    end
  end
end