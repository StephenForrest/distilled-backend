# frozen_string_literal: true

Sentry.init do |config|
  config.enabled_environments = %w[production]
  config.dsn = 'https://f3d7fa88f6c9469e925b49af61818023@o4504371094159360.ingest.sentry.io/4504371095142401'
  config.breadcrumbs_logger = %i[active_support_logger http_logger]

  # To activate performance monitoring, set one of these options.
  # We recommend adjusting the value in production:
  config.traces_sample_rate = 1.0
  # or
  config.traces_sampler = lambda do |_context|
    true
  end
end
