class UserPolicy < ApplicationPolicy
  # attr_reader :user
  #
  # def initialize(user)
  #   @user = user
  # end

  def index?
    user.admin?
  end

  def show?
    user.admin?
  end

  def new?
  end

  def create?
  end

  def edit?
    user.admin? || @user == user
  end

  def update?
    user.admin? || @user == user
  end

  def destroy?
    user.admin?
  end

end
