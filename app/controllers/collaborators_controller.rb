class CollaboratorsController < ApplicationController

  def new
    @collaborator = Collaborator.new
  end

  def create
    #get the ids of the users whose boxed were checked
    @user_ids = params[:user_ids]
    @wiki_id = params[:wiki_id]

    @collaborators = Wiki.where(id: @wiki_id).first.collaborators

    #loop through all users. if their email is checked then add them to this wiki's collaborators
    #unless they're already there
    #else remove them if they did exist as a collaborator
    if @user_ids == nil
      @collaborators.all.each {|collab| collab.destroy} unless @collaborators.empty?
    else
      if @collaborators.empty?
        @user_ids.each do |id|
          @collaborators.create!(email: User.where(id: id).first.email)
        end
      else
        User.all.each do |user|
          if @user_ids.include?(user.id.to_s)
            unless @collaborators.pluck(:email).include?(user.email)
              @collaborators.create!(email: user.email)
            end
          else
            unless @collaborators.where(email: user.email).first == nil
              @collaborators.where(email: user.email).first.destroy
            end
         end
        end
      end
    end
    flash[:notice] = "Collaborators updated successfully"
    redirect_to edit_wiki_path(@wiki_id)

  end

end
