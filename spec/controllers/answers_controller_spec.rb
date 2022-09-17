# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
  let(:question) { create(:question) }

  describe 'GET #index' do
    let(:answers) { create_list(:answer, 3, question: question) }

    before { get :index, params: { question_id: question } }

    it 'populates an array of all answers for the question' do
      expect(assigns(:answers)).to match_array(answers)
    end

    it 'assigns the requested question to @question' do
      expect(assigns(:question)).to eq(question)
    end

    it 'renders index view' do
      expect(response).to render_template :index
    end
  end

  describe 'GET #new' do
    before { get :new, params: { question_id: question } }

    it 'renders new view' do
      expect(response).to render_template :new
    end
  end

  describe 'POST #create' do
    let(:request) { post :create, params: { question_id: question, answer: answer_params } }
    let(:answer_params) { attributes_for(:answer) }

    context 'with valid attributes' do
      it 'saves a new question in the db' do
        expect { request }.to change(Answer, :count).by(1)
      end

      it 'redirects to index view' do
        request
        expect(response).to redirect_to question_answers_path(assigns(:question))
      end
    end

    context 'with invalid attributes' do
      let(:answer_params) { attributes_for(:answer, :invalid) }

      it 'do not save the answer' do
        expect { request }.not_to change(Answer, :count)
      end

      it 're-render new view' do
        request
        expect(response).to render_template :new
      end
    end
  end

  describe 'GET #edit' do
    let(:answer) { create(:answer) }

    before { get :edit, params: { id: answer } }

    it 'renders edit view' do
      expect(response).to render_template :edit
    end
  end

  describe 'PATCH #update' do
    let(:answer) { create(:answer, question: question) }
    let(:request) { patch :update, params: { id: answer, answer: answer_params } }

    context 'with valid attributes' do
      let(:answer_params) { { body: 'new body' } }

      it 'assigns the requested answer to @answer' do
        request

        expect(assigns(:answer)).to eq answer
      end

      it 'changes answer attributes' do
        request

        answer.reload
        expect(answer.body).to eq 'new body'
      end

      it 'redirects to index view' do
        request
        expect(response).to redirect_to question_answers_path(assigns(:question))
      end
    end

    context 'with invalid attributes' do
      let(:answer_params) { attributes_for(:answer, :invalid) }

      before { request }

      it 'does not change question attributes' do
        question.reload

        expect(question.body).to eq 'MyText'
      end

      it 're-render edit view' do
        expect(response).to render_template :edit
      end
    end
  end
end
