class WikiPolicy < ApplicationPolicy
  # #attr_reader :user, :wiki
  attr_reader :record
  #
  # def initialize(user, wiki)
  #   @user = user
  #   @wiki = wiki
  # end

  def update?
    user.admin? || user.id == record.user_id
  end

  def destroy?
    user.admin? || user.id == record.user_id
  end

end
