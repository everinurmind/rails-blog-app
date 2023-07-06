require_relative '../models/user'

class ApplicationController < ActionController::Base
  def current_user
    @current_user ||= User.first
  end
  helper_method :current_user
end