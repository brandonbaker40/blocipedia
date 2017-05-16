class WikiPolicy < ApplicationPolicy
  # #attr_reader :user, :wiki
  attr_reader :record
  #
  # def initialize(user, wiki)
  #   @user = user
  #   @wiki = wiki
  # end

  def index?
  end

  def show?
  end

  def new?
  end

  def create?
  end

  def edit?
  end

  def update?
    user.admin? || wiki.try(:user) == user
  end

  def destroy?
    user.admin? || wiki.try(:user) == user
  end

end
