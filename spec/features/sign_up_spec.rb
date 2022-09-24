# frozen_string_literal: true

require 'rails_helper'

describe 'User can sign-up', "
  In order to ask questions
  As an user
  I'd like to be able to create account
" do
  let(:user) { create(:user) }

  before { visit new_user_registration_path }

  it 'Unregistered user can create account' do
    fill_in 'Email', with: 'emailtest@test.com'
    fill_in 'Password', with: '123456'
    fill_in 'Password confirmation', with: '123456'

    click_button 'Sign up'

    expect(page).to have_content 'Welcome! You have signed up successfully'
  end

  it 'Registered user tries to sign in' do
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    fill_in 'Password confirmation', with: user.password

    click_button 'Sign up'

    expect(page).to have_content 'Email has already been taken'
  end
end
