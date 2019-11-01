require 'rails_helper'

RSpec.describe Article, type: :model do
  describe '.create' do
    subject { described_class.create(params) }

    let(:params) { build(:article).as_json.except(:articles_count) }

    context 'success' do
      it { expect { subject }.to change { described_class.count }.by(1) }
    end

    context 'failure' do
      let(:params) { super().merge(name: nil) }

      it { expect { subject }.to change { described_class.count }.by(0) }
    end
  end

  describe '.recalculate_kind_counter' do
    subject { story.reload.articles_kind_count }

    let(:story) { create :story }

    before do
      create(:article, kind: :twitter, story: story)
      create(:article, kind: :facebook, story: story)
      create(:article, kind: :blog, story: story)
    end

    it { expect(subject).to eq(3) }
  end
end
