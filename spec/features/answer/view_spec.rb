# frozen_string_literal: true

require 'rails_helper'

describe 'User can view list of answers on the question page', "
  In order to see answers from a community
  As an user
  I'd like to be able to see the question and answers
" do
  let(:user) { create(:user) }
  let!(:question) { create(:question, :with_answers) }
  let!(:answers) { question.answers }

  before do
    visit question_path(question)
  end

  it 'Authenticated user sees answers for the question' do
    sign_in user

    answers.each do |answer|
      expect(page).to have_content answer.body
    end
  end

  it 'Unauthenticated user sees answers for question' do
    answers.each do |answer|
      expect(page).to have_content answer.body
    end
  end
end
