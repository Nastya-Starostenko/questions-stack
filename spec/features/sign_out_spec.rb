# frozen_string_literal: true

require 'rails_helper'

describe 'User can sign-out', "
  As an authenticated user
  I'd like to be able to sign out
" do
  let(:user) { create(:user) }

  it 'Registered user tries to sign in' do
    sign_in user

    click_on 'Sign Out'

    expect(page).to have_content 'Signed out successfully.'
  end

  it 'Unregistered user can\'t see sign out link' do
    visit root_path
    expect(page).not_to have_content 'Sign Out'
  end
end
