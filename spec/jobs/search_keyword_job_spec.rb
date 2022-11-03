# frozen_string_literal: true

RSpec.describe SearchKeywordJob, type: :job do
  include ActiveJob::TestHelper

  describe '#perform' do
    context 'given a valid request' do
      it 'sets the keyword status as completed' do
        VCR.use_cassette('jobs/search_keyword', record: :once) do
          keyword = Fabricate(:keyword)
          described_class.perform_now keyword.id

          expect(keyword.reload.status).to eq('completed')
        end
      end
    end
  end
end
