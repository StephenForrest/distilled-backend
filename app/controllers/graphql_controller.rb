# frozen_string_literal: true

class GraphqlController < ApplicationController
  # If accessing from outside this domain, nullify the session
  # This allows for outside API access while preventing CSRF attacks,
  # but you'll have to authenticate your user separately
  # protect_from_forgery with: :null_session

  def execute
    variables = prepare_variables(params[:variables])
    query = params[:query]
    operation_name = params[:operationName]
    context = {
      current_user:,
      current_workspace:
    }
    result = ApiGetdistilledIoSchema.execute(query, variables:, context:, operation_name:)
    render json: result
  rescue StandardError => e
    raise e unless Rails.env.development?

    handle_error_in_development(e)
  end

  private

  def parse_session_id
    pattern = /^Bearer /
    header = request.headers['authorization'] # <= env
    header.gsub(pattern, '') if header&.match(pattern)
  end

  def current_user
    @current_user ||= begin
      session_id = parse_session_id
      return nil if session_id.blank?

      user_session = UserSession.active.find_by(session_id:)
      return nil if user_session.blank?

      user_session.user
    end
  end

  def current_workspace
    @current_workspace ||= begin
      return nil if current_user.blank?

      current_user.workspaces.first
    end
  end

  # Handle variables in form data, JSON body, or a blank value
  def prepare_variables(variables_param)
    case variables_param
    when String
      if variables_param.present?
        JSON.parse(variables_param) || {}
      else
        {}
      end
    when Hash
      variables_param
    when ActionController::Parameters
      variables_param.to_unsafe_hash # GraphQL-Ruby will validate name and type of incoming variables.
    when nil
      {}
    else
      raise ArgumentError, "Unexpected parameter: #{variables_param}"
    end
  end

  def handle_error_in_development(e)
    logger.error e.message
    logger.error e.backtrace.join("\n")

    render json: { errors: [{ message: e.message, backtrace: e.backtrace }], data: {} },
           status: :internal_server_error
  end
end
