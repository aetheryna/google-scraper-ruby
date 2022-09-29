# frozen_string_literal: true

require 'rails_helper'

RSpec.describe GoogleSearchService, type: :service do
  describe '#call' do
    context 'when searching a simple keyword' do
      it 'returns an response' do
        VCR.use_cassette('services/google_search_service', record: :once) do
          result = described_class.new(FFaker::Lorem.word).call

          expect(result).to be_an_instance_of(HTTParty::Response)
        end
      end
    end
  end
end
