require 'rails_helper'

describe WikiPolicy do
  subject { described_class.new(user, wiki) }

  let(:wiki) { Wiki.create }

  context 'being a standard user' do
    let(:user) { User.create(role: :standard, email: 'standard@example.com', password: '123123standard') }

    it { is_expected.to permit_actions([:index, :show, :new, :create, :edit, :update]) }
    it { is_expected.to forbid_action(:destroy) }
  end

  context 'being a premium user' do
    let(:user) { User.create(role: :premium, email: 'premium@example.com', password: '123123premium') }

    it { is_expected.to permit_actions([:index, :show, :new, :create, :edit, :update]) }
    it { is_expected.to forbid_action(:destroy) }
  end

  context 'being an admin user' do
    let(:user) { User.create(role: :admin, email: 'admin@example.com', password: '123123admin') }

    it { is_expected.to permit_actions([:index, :show, :new, :create, :edit, :update, :destroy]) }
  end
end
