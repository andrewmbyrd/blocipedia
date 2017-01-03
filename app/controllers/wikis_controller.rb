class WikisController < ApplicationController

  def index
    @wikis = policy_scope(Wiki)
  end

  def new
    @wiki = Wiki.new
  end

  def show
    @wiki = Wiki.find(params[:id])
  end

  def edit
    @wiki = Wiki.find(params[:id])
  end

  def create
    @wiki = Wiki.new

    @wiki.title = params[:wiki][:title]
    @wiki.body = params[:wiki][:body]
    @wiki.private = params[:wiki][:private]
    @wiki.user = User.find_by(email: current_user.email)

    if @wiki.save
      redirect_to @wiki, notice: "Wiki was saved successfully"
    else
      flash.now[:alert] = "Error saving the wiki. Please try again"
      render :new
    end

  end

  def destroy
    @wiki = Wiki.find(params[:id])

    authorize @wiki

    if @wiki.destroy
      flash[:notice] = 'This wiki was successfully deleted'
      redirect_to action: :index
    else
      flash[:notice] = "There was an error deleting this wiki"
      render :show
    end

  end

  def update
    #isolate the wiki we want to update
    @wiki = Wiki.find(params[:id])

    #this is using Pundit to verify that the current_user has permisions
    authorize @wiki

    #if the wiki was able to be authorized, allow it to be updated and then
    #attempt to save as normal



      #update the selected wiki with the new parameters
      @wiki.title = params[:wiki][:title]
      @wiki.body = params[:wiki][:body]
      @wiki.private = params[:wiki][:private]

      if @wiki.save
        redirect_to @wiki, notice: "Wiki was updated successfully"
      else
        flash.now[:alert] = "Error updating the wiki. Please try again"
        render :edit
      end


  #end the update method
  end

  private
  def user_not_authorized
    flash[:alert] = "You are not authorized to change this wiki. Consider upgrading to our premium plan :)"
    redirect_to wikis_path
  end
#end the controller
end
