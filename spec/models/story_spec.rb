require 'rails_helper'

RSpec.describe Story, type: :model do
  describe '.create' do
    subject { described_class.create(params) }

    let(:params) { attributes_for(:story) }

    context 'success' do
      it { expect { subject }.to change { described_class.count }.by(1) }
    end

    context 'failure' do
      let(:params) { super().merge(name: nil) }

      it { expect { subject }.to change { described_class.count }.by(0) }
    end
  end
end
