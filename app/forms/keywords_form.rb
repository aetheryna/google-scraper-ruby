# frozen_string_literal: true

require 'csv'

class KeywordsForm
  include ActiveModel::Model

  validates_with KeywordsFormValidator

  attr_accessor :file, :user, :keywords

  def save(params)
    assign_attributes(params)

    return false if invalid?

    begin
      Keyword.create(parse_keywords_from_file(keywords)).map { |keyword| keyword['id'] } if parse_keywords(params[:file])
    rescue ActiveRecord::ActiveRecordError => e
      errors.add("Error: #{e}")
    end

    errors.empty?
  end

  private

  def parse_keywords_from_file(keyword_records)
    keyword_records.map { |keyword| add_keyword_record(keyword) }
  end

  def parse_keywords(file)
    csv_data = CSV.read(file)
    assign_attributes(keywords: csv_data.map(&:first).compact_blank)
  end

  def add_keyword_record(keyword)
    return nil if keyword.blank?

    {
      user_id: user.id,
      keyword: keyword
    }
  end
end
