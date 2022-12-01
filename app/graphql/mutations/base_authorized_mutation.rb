# frozen_string_literal: true

module Mutations
  class BaseAuthorizedMutation < BaseMutation
    def self.authorized?(object, context)
      super && context[:current_user].present?
    end

    def current_user
      @current_user ||= context[:current_user]
    end

    def current_workspace
      @current_workspace ||= context[:current_workspace]
    end
  end
end
