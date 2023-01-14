# frozen_string_literal: true

require 'sidekiq/web'

Rails.application.routes.draw do
  get '/health', to: proc { [200, {}, ['success']] }

  post '/execute', to: 'graphql#execute'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  post '/slack-event', to: 'slack#event'
  post '/slack-webhooks', to: 'slack#webhooks'
  get '/oauth-google', to: 'google_auth#auth'

  unless Rails.env.development?
    Sidekiq::Web.use(Rack::Auth::Basic) do |username, password|
      # Protect against timing attacks:
      # - See https://codahale.com/a-lesson-in-timing-attacks/
      # - See https://thisdata.com/blog/timing-attacks-against-string-comparison/
      # - Use & (do not use &&) so that it doesn't short circuit.
      # - Use digests to stop length information leaking
      # (see also ActiveSupport::SecurityUtils.variable_size_secure_compare)
      ActiveSupport::SecurityUtils.secure_compare(
        ::Digest::SHA256.hexdigest(username),
        ::Digest::SHA256.hexdigest(ENV.fetch('SIDEKIQ_USER'))
      ) & ActiveSupport::SecurityUtils.secure_compare(
        ::Digest::SHA256.hexdigest(password),
        ::Digest::SHA256.hexdigest(ENV.fetch('SIDEKIQ_PASSWORD'))
      )
    end
  end
  mount(::Sidekiq::Web => '/sidekiq')
end
