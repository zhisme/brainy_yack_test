require 'rails_helper'

RSpec.describe SqlCommandDefiner do
  describe '.search?' do
    subject { described_class.search?(params) }

    let(:params) { {term: 'foo'} }

    it { expect(subject).to eq(true) }
  end

  describe '.sort?' do
    subject { described_class.sort?(params) }

    let(:params) { {sort_by: 'foo'} }

    it { expect(subject).to eq(true) }
  end

  describe '.group?' do
    subject { described_class.group?(params) }

    let(:params) { {group_by: 'foo'} }

    it { expect(subject).to eq(true) }
  end

  describe '.group_by_story?' do
    subject { described_class.group_by_story?(params) }

    let(:params) { {group_by_story: 'foo'} }

    it { expect(subject).to eq(true) }
  end
end
