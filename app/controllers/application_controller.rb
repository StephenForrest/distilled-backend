# frozen_string_literal: true

class ApplicationController < ActionController::API
  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def current_workspace
    @current_workspace ||= Workspace.find_by(id: session[:workspace_id])
  end
end
