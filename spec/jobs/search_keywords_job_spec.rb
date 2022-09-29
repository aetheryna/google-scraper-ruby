# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SearchKeywordsJob, type: :job do
  include ActiveJob::TestHelper

  describe '#perform' do
    context 'given 2 keywords' do
      it 'queues a search job with keywords' do
        keyword_ids = Fabricate.times(2, :keyword).map(&:id)

        expect { described_class.perform_later keyword_ids }.to have_enqueued_job(described_class)
      end

      it 'queues 3 search keyword jobs' do
        keyword_ids = Fabricate.times(3, :keyword).map(&:id)

        expect { described_class.perform_now keyword_ids }.to have_enqueued_job(SearchKeywordJob).exactly(:thrice)
      end
    end
  end
end
