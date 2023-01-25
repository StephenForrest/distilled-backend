# frozen_string_literal: true

class SentryIO
  def write(message)
    Sentry.capture_message(message)
  end

  def close; end
end

def enable_sentry_logger
  sentry_logger = ActiveSupport::Logger.new(SentryIO.new, level: Logger::ERROR)
  Rails.logger.extend(ActiveSupport::Logger.broadcast(sentry_logger))
end

Sentry.init do |config|
  config.enabled_environments = %w[production development staging]
  if Rails.env.production?
    config.environment = Rails.env
    config.dsn = 'https://40a85c32a3e84e2e935db7a272ee3759@o4504376872796160.ingest.sentry.io/4504453747572736'
  end
  config.breadcrumbs_logger = %i[active_support_logger http_logger]

  # To activate performance monitoring, set one of these options.
  # We recommend adjusting the value in production:
  config.traces_sample_rate = 1.0
  # or
  config.traces_sampler = lambda do |_context|
    true
  end

  enable_sentry_logger
end
