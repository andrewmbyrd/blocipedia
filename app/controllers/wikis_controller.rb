class WikisController < ApplicationController

  def index
    @wikis = Wiki.all
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

    #update the selected wiki with the new parameters
    @wiki.title = params[:wiki][:title]
    @wiki.body = params[:wiki][:body]
    @wiki.private = params[:wiki][:private]

    if @wiki.save
      redirect_to @wiki, notice: "Wiki was updated successfully"
    else
      flash.now[:alert] = "Error updating the wiki. Please try again"
      render :new
    end
  end


end
