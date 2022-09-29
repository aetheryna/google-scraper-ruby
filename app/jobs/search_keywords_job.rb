# frozen_string_literal: true

class SearchKeywordsJob < ApplicationJob
  queue_as :default

  def perform(keyword_ids)
    keyword_ids.each do |keyword_id|
      SearchKeywordJob.set(wait: 3).perform_later(keyword_id)
    end
  end
end
