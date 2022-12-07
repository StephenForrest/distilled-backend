# frozen_string_literal: true

class ValidationErrors
  def initialize
    @errors = {}
  end

  def add(key, value)
    @errors[key] = value
  end

  def present?
    !@errors.keys.empty?
  end

  def blank?
    @errors.keys.empty?
  end

  def serialize
    serialized_errors = {}
    @errors.each do |key, value|
      serialized_errors[camelize_key(key)] = value.is_a?(ValidationErrors) ? value.serialize : value
    end
    serialized_errors
  end

  def camelize_key(key)
    key.include?('-') ? key : key.camelize(:lower)
  end
end
