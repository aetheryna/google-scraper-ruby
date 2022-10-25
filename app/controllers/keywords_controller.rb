# frozen_string_literal: true

class KeywordsController < ApplicationController
  before_action :authenticate_user!
  # after_action :perform_job, only: :create

  def index
    keywords = current_user.keywords
    keyword_presenters = keywords.map { |keyword| KeywordPresenter.new(keyword) }

    render locals: {
      keyword_presenter: keyword_presenters
    }
  end

  def create
    if keywords_form.save({ file: keyword_params, user: current_user })
      flash[:notice] = t('csv.upload_success')
    else
      flash[:alert] = keywords_form.errors.full_messages.first
    end

    redirect_to keywords_path
  end

  private

  def keywords_form
    @keywords_form ||= KeywordsForm.new(user: current_user)
  end

  def perform_job
    SearchKeywordsJob.perform_later(keywords_form.keyword_ids)
  end

  def keyword_params
    params.require(:keywords_file)
  end
end
