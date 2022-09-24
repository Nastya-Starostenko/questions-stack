# frozen_string_literal: true

require 'rails_helper'

feature 'User can create answer', "
  In order to give answer to a community
  As an authenticated user
  I'd like to be able to give answer for the question
" do
  given(:user) { create(:user) }
  given!(:question) { create(:question, :with_answers) }

  describe 'Authenticated user ' do
    background do
      sign_in user

      visit question_path(question)
    end

    scenario 'answer to a question' do
      fill_in 'Body', with: 'text text text'
      click_on 'Answer'

      expect(page).to have_content 'Your answer successfully created'
    end

    scenario 'answer to a question with errors' do
      click_on 'Answer'

      expect(page).to have_content 'Body can\'t be blank'
    end
  end

  scenario 'Unauthenticated user tries to answer to a question' do
    visit question_path(question)

    fill_in 'Body', with: 'text text text'
    click_on 'Answer'

    expect(page).to have_content 'You need to sign in or sign up before continuing.'
  end
end
