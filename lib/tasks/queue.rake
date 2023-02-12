namespace :sidekiq do
    desc "Clear Sidekiq queue"
    task clear: :environment do
      require 'sidekiq/api'
      Sidekiq::Queue.new.clear
      puts "Sidekiq queue is now empty!"
    end
  end
  