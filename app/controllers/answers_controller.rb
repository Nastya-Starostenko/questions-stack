# frozen_string_literal: true

class AnswersController < ApplicationController
  before_action :find_answer, only: %i[edit update]
  before_action :find_question, only: %i[new index create]

  def index
    @answers = @question.answers
  end

  def new
    @question.answers.new
  end

  def create
    @answer = @question.answers.new(answer_params)

    if @answer.save
      redirect_to question_answers_path(@question)
    else
      render :new
    end
  end

  def edit; end

  def update
    @question = @answer.question
    if @answer.update(answer_params)
      redirect_to question_answers_path(@question)
    else
      render :edit
    end
  end

  private

  def find_question
    @question ||= Question.find(params[:question_id])
  end

  def find_answer
    @answer ||= Answer.find(params[:id])
  end

  def answer_params
    params.require(:answer).permit(:body)
  end
end
