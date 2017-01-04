class ApplicationController < ActionController::Base
  include Pundit
  protect_from_forgery with: :exception

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  before_action :authenticate_user!

  #after_action :verify_authorized, except: :index
  #after_action :verify_policy_scoped, only: :index

end
