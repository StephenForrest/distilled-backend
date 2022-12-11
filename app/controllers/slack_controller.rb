# frozen_string_literal: true

class SlackController < ApplicationController
  def event
    Rails.logger.debug params.inspect
    render json: { "challenge": params['challenge'] }
  end
end
