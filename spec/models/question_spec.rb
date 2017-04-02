require 'rails_helper'

RSpec.describe Question do
  it 'has a valid factory' do
    expect(build(:question)).to be_valid
  end

  context 'associations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to have_many(:votes) }
    it { is_expected.to have_many(:answers) }
    it { is_expected.to have_many(:comments) }
  end

  context 'validations' do
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_length_of(:title).is_at_most(100) }
    it { is_expected.to validate_presence_of(:body) }
    it { is_expected.to validate_length_of(:body).is_at_most(800) }
  end

  context 'instance methods' do
    describe '#belong_user' do
      it 'returns if a question belong to user' do
        user = create(:user)
        question = create(:question)

        expect(question.belong_user(user)).to eq false
      end
    end
  end
end