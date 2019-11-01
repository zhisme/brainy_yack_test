require 'rails_helper'

RSpec.describe QueryParamsToCollection do
  describe '.call' do
    subject { described_class.call(params) }

    let(:article) { create :article }

    context 'success' do
      let(:params) { {term: 'MyName'} }

      before do
        allow(Validator).to receive(:call).and_return(nil)
        allow(CollectionBuilder).to receive(:call).and_return([article])
      end

      it { expect(subject.success?).to eq(true) }
      it { expect(subject.collection).to eq([article]) }
    end

    context 'failure' do
      let(:params) { {invalid: true} }

      context 'validator raised error' do
        before do
          allow(Validator).to receive(:call).and_raise(Validator::QueryParamsInvalid)
        end

        it { expect(subject.success?).to eq(false) }
      end

      context 'collection builder raised error' do
        before do
          allow(Validator).to receive(:call).and_return(nil)
          allow(CollectionBuilder).to receive(:call)
            .and_raise(CollectionBuilder::CollectionNotBuilded)
        end

        it { expect(subject.success?).to eq(false) }
      end
    end
  end
end
