# frozen_string_literal: true

require 'rails_helper'

describe 'User can view list of questions', "
  In order to finding a decision
  As an user
  I'd like to be able to see list of questions
" do
  let(:user) { create(:user) }
  let!(:questions) { [create(:question), create(:question)] }

  before do
    visit questions_path
  end

  it 'Authenticated user sees the list of questions' do
    sign_in user

    expect(page).to have_content questions[0].title
    expect(page).to have_content questions[1].title
  end

  it 'Unauthenticated user sees the list of questions' do
    expect(page).to have_content questions[0].title
    expect(page).to have_content questions[1].title
  end
end
