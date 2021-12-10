require 'rails_helper'

RSpec.describe Foobar, type: :model do
  fixtures :foobars

  before { freeze_time }
  after { unfreeze_time }

  describe '#expired_at' do
    subject { Foobar.new.expires_at }
    it { is_expected.to eql 30.days.from_now }
  end

  describe '.active' do
    subject(:active) { Foobar.active }
    it { is_expected.to contain_exactly foobars(:active_published), foobars(:active_draft) }

    context '.published' do
      subject(:active_published) { active.published }
      it { is_expected.to contain_exactly foobars(:active_published) }
    end

    context '.draft_inverse_of' do
      subject(:active_draft_inverse_of) { active.draft_inverse_of }
      it { is_expected.to contain_exactly foobars(:active_draft) }
    end

    context '.draft_invert_where' do
      subject(:active_draft_invert_where) { active.draft_invert_where }
      it { is_expected.to_not contain_exactly foobars(:active_draft) }
    end
  end

  describe '.expired_inverse_of' do
    subject(:expired_inverse_of) { Foobar.expired_inverse_of }
    it { is_expected.to contain_exactly foobars(:expired_published), foobars(:expired_draft) }

    context '.published' do
      subject(:expired_inverse_of_published) { expired_inverse_of.published }
      it { is_expected.to contain_exactly foobars(:expired_published) }
    end

    context '.draft_inverse_of' do
      subject(:expired_inverse_of_draft_inverse_of) { expired_inverse_of.draft_inverse_of }
      it { is_expected.to contain_exactly foobars(:expired_draft) }
    end

    context '.draft_invert_where' do
      subject(:expired_inverse_of_draft_invert_where) { expired_inverse_of.draft_invert_where }
      it { is_expected.to_not contain_exactly foobars(:expired_draft) }
    end
  end

  describe '.expired_invert_where' do
    subject(:expired_invert_where) { Foobar.expired_invert_where }
    it { is_expected.to contain_exactly foobars(:expired_published), foobars(:expired_draft) }

    context '.published' do
      subject(:expired_invert_where_published) { expired_invert_where.published }
      it { is_expected.to contain_exactly foobars(:expired_published) }
    end

    context '.draft_inverse_of' do
      subject(:expired_invert_where_draft_inverse_of) { expired_invert_where.draft_inverse_of }
      it { is_expected.to contain_exactly foobars(:expired_draft) }
    end

    context '.draft_invert_where' do
      subject(:expired_invert_where_draft_invert_where) { expired_invert_where.draft_invert_where }
      it { is_expected.to_not contain_exactly foobars(:expired_draft) }
    end
  end

  describe '.published' do
    subject(:published) { Foobar.published }
    it { is_expected.to contain_exactly foobars(:active_published), foobars(:expired_published) }

    context '.active' do
      subject(:published_active) { published.active }
      it { is_expected.to contain_exactly foobars(:active_published) }
    end

    context '.expired_inverse_of' do
      subject(:published_expired_inverse_of) { published.expired_inverse_of }
      it { is_expected.to contain_exactly foobars(:expired_published) }
    end

    context '.expired_invert_where' do
      subject(:published_expired_invert_where) { published.expired_invert_where }
      it { is_expected.to_not contain_exactly foobars(:expired_published) }
    end
  end

  describe '.draft_inverse_of' do
    subject(:draft_inverse_of) { Foobar.draft_inverse_of }
    it { is_expected.to contain_exactly foobars(:active_draft), foobars(:expired_draft) }

    context '.active' do
      subject(:draft_inverse_of_active) { draft_inverse_of.active }
      it { is_expected.to contain_exactly foobars(:active_draft) }
    end

    context '.expired_inverse_of' do
      subject(:draft_inverse_of_expired_inverse_of) { draft_inverse_of.expired_inverse_of }
      it { is_expected.to contain_exactly foobars(:expired_draft) }
    end

    context '.expired_invert_where' do
      subject(:draft_inverse_of_expired_invert_where) { draft_inverse_of.expired_invert_where }
      it { is_expected.to_not contain_exactly foobars(:expired_draft) }
    end
  end

  describe '.draft_invert_where' do
    subject(:draft_invert_where) { Foobar.draft_invert_where }
    it { is_expected.to contain_exactly foobars(:active_draft), foobars(:expired_draft) }

    context '.active' do
      subject(:draft_invert_where_active) { draft_invert_where.active }
      it { is_expected.to contain_exactly foobars(:active_draft) }
    end

    context '.expired_inverse_of' do
      subject(:draft_invert_where_expired_inverse_of) { draft_invert_where.expired_inverse_of }
      it { is_expected.to contain_exactly foobars(:expired_draft) }
    end

    context '.expired_invert_where' do
      subject(:draft_invert_where_expired_invert_where) { draft_invert_where.expired_invert_where }
      it { is_expected.to_not contain_exactly foobars(:expired_draft) }
    end
  end
end
