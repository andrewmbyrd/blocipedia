class WikiPolicy < ApplicationPolicy
  attr_reader :user, :wiki

  def initialize(user, wiki)
    @user = user
    @wiki = wiki
  end

  def update?
    wiki.user == user || (!wiki.private? && user.present?)
  end

  def destroy?
    user.admin?
  end

  class Scope < Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope =  scope
    end

    def resolve
      if user.admin? || user.premium?
        scope.all
      else
        scope.where(private: false).or(scope.where(user: @user))
      end
    end

  end

end
