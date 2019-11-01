require 'rails_helper'

RSpec.describe Api::V1::ArticlesController, type: :controller do
  describe 'GET index' do
    subject { get :index, params: params }

    let(:articles) { create_list :article, 10 }

    before do
      articles
    end

    let(:params) { {} }

    it 'returns all articles without query params', :aggregate_failure do
      should be_ok
      expect(json_body.size).to eq(10)
    end

    context 'search' do
      context 'success' do
        let(:params) { super().merge(term: 'MyName') }

        before do
          result = double(QueryParamsToCollection)

          allow(QueryParamsToCollection).to receive(:call).and_return(result)
          allow(result).to receive(:success?).and_return(true)
          allow(result).to receive(:collection).and_return(articles)
        end

        it { should be_ok }
        it { expect(json_body.size).to eq(10) }
      end

      context 'failure' do
        let(:params) { super().merge(sort_by: :invalid) }

        before do
          result = double(QueryParamsToCollection)

          allow(QueryParamsToCollection).to receive(:call).and_return(result)
          allow(result).to receive(:success?).and_return(false)
        end

        it { expect(subject.status).to eq(422) }
      end
    end
  end
end
