# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Question, type: :model do
  describe 'relations' do
    it { is_expected.to have_many(:answers).dependent(:destroy) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of :title }
    it { is_expected.to validate_presence_of :body }
  end
end
