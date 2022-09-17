# frozen_string_literal: true

class AnswersController < ApplicationController
  def index
    @answers = question.answers
  end

  def new; end

  def create
    @answer = question.answers.new(answer_params)

    if @answer.save
      redirect_to question_answers_path(question)
    else
      render :new
    end
  end

  def edit; end

  def update
    if answer.update(answer_params)
      redirect_to question_answers_path(question)
    else
      render :edit
    end
  end

  private

  helper_method :question, :answer

  def question
    @question ||= params[:question_id] ? Question.find(params[:question_id]) : answer.question
  end

  def answer
    @answer ||= params[:id] ? Answer.find(params[:id]) : question.answers.new
  end

  def answer_params
    params.require(:answer).permit(:body)
  end
end
