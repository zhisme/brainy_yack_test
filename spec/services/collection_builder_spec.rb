require 'rails_helper'

RSpec.describe CollectionBuilder do
  describe '.call' do
    subject { described_class.call(params, collection) }

    let(:params) { {} }
    let(:collection) { Article.all }
    let(:story) { create :story }

    before do
      create_list :article, 2, story: story
      3.times do |i|
        create :article, name: "other_name_#{i}", kind: :twitter
      end
    end

    context 'search' do
      let(:params) { super().merge(term: 'MyName') }

      it { expect(subject.size).to eq(2) }
    end

    context 'sort' do
      context 'sort_by only' do
        let(:params) { super().merge(sort_by: 'kind') }

        it { expect(subject.first.kind).to eq('facebook') }
      end

      context 'with direction' do
        let(:params) { super().merge(sort_by: 'kind', sort_direction: 'asc') }

        it { expect(subject.first.kind).to eq('twitter') }
      end
    end

    context 'group' do
      let(:params) { super().merge(group_by: 'kind') }

      it { expect(subject['facebook'].size).to eq(2) }
      it { expect(subject['twitter'].size).to eq(3) }
    end

    context 'group_by_story' do
      context 'articles_count' do
        let(:params) { super().merge(group_by_story: 'articles_count') }

        before do
          create_list :article, 2, story: story
        end

        it { expect(subject.first.map(&:story_id).uniq).to eq([story.id]) }
        it { expect(subject.first.size).to eq(4) }
        it { expect(story.articles_count).to eq(4) }
      end

      context 'article_kind_count' do
        let(:params) { super().merge(group_by_story: 'articles_kind_count') }

        before do
          create :article, story: story, kind: :blog
          create :article, story: story, kind: :twitter
        end

        it { expect(subject.first.map(&:story_id).uniq).to eq([story.id]) }
        it { expect(subject.first.size).to eq(4) }
        it { expect(subject.first.map(&:kind)).to eq(%w[facebook facebook blog twitter]) }
        it { expect(story.articles_kind_count).to eq(3) }
      end
    end
  end
end
