# frozen_string_literal: true

module Resolvers
  class BaseResolver < GraphQL::Schema::Resolver
    def initialize(...)
      super(...)
      raise GraphQL::ExecutionError, 'Authentication expired' if context[:current_user].blank?
    end

    def current_user
      @current_user ||= context[:current_user]
    end

    def current_workspace
      @current_workspace ||= context[:current_workspace]
    end
  end
end
