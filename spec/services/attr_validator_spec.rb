require 'rails_helper'

RSpec.describe AttrValidator do
  describe '.call' do
    subject { described_class.call(params) }

    context 'success' do
      context 'group_by' do
        let(:params) { {group_by: described_class::PERMITTED_ATTRS.sample} }

        it { expect { subject }.to_not raise_error }
      end

      context 'sort_by' do
        let(:params) { {sort_by: described_class::PERMITTED_ATTRS.sample} }

        it { expect { subject }.to_not raise_error }

        context 'with sort_direction' do
          let(:params) { super().merge(sort_direction: described_class::SORT_DIRECTION.sample) }

          it { expect { subject }.to_not raise_error }
        end
      end

      context 'group_by_story' do
        let(:params) { {group_by_story: described_class::STORY_PERMITTED_ATTRS.sample} }

        it { expect { subject }.to_not raise_error }
      end
    end

    context 'failure' do
      context 'sort_by' do
        let(:params) { {group_by: 'invalid'} }

        it { expect { subject }.to raise_error(AttrValidator::AttrValueInvalid) }
      end

      context 'sort_by' do
        let(:params) { {sort_by: 'invalid'} }

        it { expect { subject }.to raise_error(AttrValidator::AttrValueInvalid) }

        context 'with sort_direction' do
          let(:params) { super().merge(sort_direction: :invalid) }

          it { expect { subject }.to raise_error(AttrValidator::AttrValueInvalid) }
        end
      end

      context 'group_by_story' do
        let(:params) { {group_by_story: 'invalid'} }

        it { expect { subject }.to raise_error(AttrValidator::AttrValueInvalid) }
      end

      context 'attr not exist' do
        let(:params) { {not_exist: 'invalid'} }

        it { expect { subject }.to raise_error(AttrValidator::AttrNotExist) }
      end
    end
  end
end
