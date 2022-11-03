# frozen_string_literal: true

class SearchKeywordJob < ApplicationJob
  queue_as :default

  def perform(keyword_id)
    keyword = Keyword.find(keyword_id)

    begin
      GoogleSearchService.new(keyword: keyword.keyword).call

      keyword.update_status(:completed)
    rescue ActiveRecord::RecordNotFound, ActiveRecord::StatementInvalid
      keyword.update_status(:failed)
    end
  end

  private

  attr_reader :keyword
end
