# frozen_string_literal: true

class SearchKeywordsJob < ApplicationJob
  queue_as :default

  def perform(_keyword_ids)
    @keyword_ids.each do |keyword_id|
      SearchKeywordJob.set(wait: 3).perform_later(keyword_id)

      Rails.logger.debug 'background job hehe'
    end
  end
end
