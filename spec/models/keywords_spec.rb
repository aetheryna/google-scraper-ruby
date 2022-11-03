# frozen_string_literal: true

# frozen_string_literal = true

RSpec.describe Keyword, type: :model do
  describe '#model' do
    context 'when model is updated' do
      it 'status reads failed' do
        keyword = Fabricate(:keyword)

        keyword.update_status(:failed)

        expect(keyword.status).to eq('failed')
      end

      it 'status reads completed' do
        keyword = Fabricate(:keyword)

        keyword.update_status(:completed)

        expect(keyword.status).to eq('completed')
      end

      it 'status reads in progress' do
        keyword = Fabricate(:keyword)

        keyword.update_status(:in_progress)

        expect(keyword.status).to eq('in_progress')
      end
    end
  end
end
