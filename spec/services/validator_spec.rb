require 'rails_helper'

RSpec.describe Validator do
  describe '.call' do
    subject { described_class.call(params) }

    let(:params) { {sort_by: 'created_at', sort_direction: 'asc'} }

    context 'success' do
      it 'defines only single command' do
        expect { subject }.to_not raise_error
      end
    end

    context 'failure' do
      let(:params) { super().merge(group_by: 'updated_at') }

      it { expect { subject }.to raise_error(Validator::QueryParamsInvalid) }
    end
  end
end
