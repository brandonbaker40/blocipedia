require 'rails_helper'

describe WikiPolicy do
  subject { described_class }

  let(:wiki) { Wiki.create }

  let(:standard_user) { User.create(role: :standard, email: 'standard@example.com', password: '123123standard') }
  let(:users_wiki) {standard_user.wikis.create(title: 'Standard title', body: 'standard body', private: false) }

  let(:premium_user) { User.create(role: :premium, email: 'premium@example.com', password: '123123premium') }
  let(:premium_users_wiki) { premium_user.wikis.create(title: 'Premium title', body: 'premium body', private: false) }

  let(:admin_user) { User.create(role: :admin, email: 'admin@example.com', password: '123123admin') }
  let(:admin_users_wiki) { admin_user.wikis.create(title: 'Admin title', body: 'admin body', private: false) }

  #standard users
  permissions :index?, :new?, :create?, :show? do
    it "grants access to wiki functions" do
      expect(subject).to permit(standard_user, wiki)
    end
  end

  permissions :edit?, :update?, :destroy? do
    it "grants access to wiki functions when user owns wiki" do
      expect(subject).to permit(standard_user, users_wiki)
    end

    it "denies access to wiki functions when user does not own wiki" do
      expect(subject).not_to permit(standard_user, wiki)
    end
  end

  #premium users
  permissions :index?, :new?, :create?, :show? do
    it "grants access to wiki functions" do
      expect(subject).to permit(premium_user, wiki)
    end
  end

  permissions :edit?, :update?, :destroy? do
    it "grants access to wiki functions when user owns wiki" do
      expect(subject).to permit(premium_user, premium_users_wiki)
    end

    it "denies access to wiki functions when user does not own wiki" do
      expect(subject).not_to permit(premium_user, wiki)
    end
  end

  #admin user
  permissions :index?, :new?, :create?, :show?, :edit?, :update?, :destroy? do
    it "grants access to all wiki functions" do
      expect(subject).to permit(admin_user, wiki)
    end
  end
  
end
