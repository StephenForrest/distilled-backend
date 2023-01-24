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
  config.enabled_environments = %w[production]
  if Rails.env.production?
    config.dsn = 'https://f3d7fa88f6c9469e925b49af61818023@o4504371094159360.ingest.sentry.io/4504371095142401'
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
