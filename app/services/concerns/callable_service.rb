# frozen_string_literal: true

module CallableService
  extend ActiveSupport::Concern

  class_methods do
    def call(...)
      new(...).call
    end
  end

  def call
    raise NotImplementedError, 'Need to define the method in descendants'
  end
end
