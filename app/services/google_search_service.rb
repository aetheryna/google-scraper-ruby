# frozen_string_literal: true

class GoogleSearchService
  BASE_URL = 'https://www.google.com/search'

  def initialize(keyword)
    @url = "#{BASE_URL}?q=#{keyword}"
    @user_agent = 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_6) AppleWebKit/605.1.15 (KHTML, like Gecko) '\
                  'Version/11.1.2 Safari/605.1.15'
  end

  def call
    HTTParty.get(@url, { headers: { 'User-Agent' => user_agent } })
  end

  private

  attr_reader :url, :user_agent
end
