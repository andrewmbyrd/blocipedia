class CollaboratorsController < ApplicationController

  def new
    @collaborator = Collaborator.new
  end

  def create
    #get the ids of the users whose boxed were checked
    @user_ids = params[:user_ids]
    @wiki_id = params[:wiki_id]

    #loop through all users. if their email is checked then add them to this wiki's collaborators
    #unless they're already there
    #else remove them if they did exist as a collaborator

    User.all.each do |user|
      if @user_ids.include?(user.id)
        unless Wiki.where(id: @wiki_id).first.collaborators.pluck(:email).include?(user.email)
          Wiki.where(id: @wiki_id).first.collaborators.create!(email: User.where(id: user.id).first.email)
        end
      #else
      #  unless Wiki.where(id: @wiki_id).first.collaborators.where(email: User.where(id: user.id).first.email).first == nil
      #    Wiki.where(id: @wiki_id).first.collaborators.where(email: User.where(id: user.id).first.email).first.destroy
        #end
      end
    end

    #@user_ids.each do |id|
      #Wiki.where(id: @wiki_id).first.collaborators.create!(email: User.where(id: id).first.email)

    redirect_to wikis_path

  end

end
