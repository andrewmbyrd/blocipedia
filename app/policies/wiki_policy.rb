class WikiPolicy < ApplicationPolicy
  attr_reader :user, :wiki

  def initialize(user, wiki)
    @user = user
    @wiki = wiki
  end

  def update?
    wiki.user == user || (!wiki.private? && user.present?) || wiki.collaborators.pluck(:email).include?(@user.email)
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
      permitted_wikis = []
      #if a user is an admin, then they can see everything
      if user.admin?
        permitted_wikis = scope.all


      #if not an admin but premium member, then the user can see public wikis,
      #his own wikis regardless of if they're public,
      #or private wikis that he/she is collaborating on
      elsif user.premium?
        all_wikis = scope.all
        #this will check each wiki one by one and add it if it meets above criteria
        all_wikis.each do |wiki|
          if !(wiki.private) || wiki.user == @user || wiki.collaborators.pluck(:email).include?(@user.email)
            permitted_wikis << wiki
          end
        end

      #if user has standard membership, s/he can see public wikis and those on which
      #he or she is a collaborator
      else
        all_wikis = scope.all
        permitted_wikis = []
        all_wikis.each do |wiki|
          if !wiki.private? || wiki.collaborators.pluck(:email).include?(@user.email)
            permitted_wikis << wiki # only show standard users public wikis and private wikis they are a collaborator on
          end
        end
      end

      permitted_wikis
    #end resolve definition
    end




  #end Scope class
  end
#end WikiPolicy class
end
