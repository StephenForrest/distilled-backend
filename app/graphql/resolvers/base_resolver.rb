# frozen_string_literal: true

module Resolvers
  class BaseResolver < GraphQL::Schema::Resolver
    def initialize(...)
      super(...)
      raise GraphQL::ExecutionError, 'Authentication expired' if context[:current_user].blank?
    end
  end
end
