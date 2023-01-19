# frozen_string_literal: true

module Zapier
  class BaseController < ApplicationController
    include ActionController::HttpAuthentication::Token::ControllerMethods

    def current_workspace_member
      @current_workspace_member ||= authenticate_with_http_token { |api_key, _| WorkspaceMember.find_by(api_key:) }
    end

    def current_workspace
      @current_workspace ||= current_workspace_member.workspace
    end

    def current_user
      @current_user ||= current_workspace_member.user
    end
  end
end
