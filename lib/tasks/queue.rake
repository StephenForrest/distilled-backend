namespace :sidekiq do
    desc "Clear Sidekiq queue"
    task clear: :environment do
      require 'sidekiq/api'
      Sidekiq::Queue.all.each(&:clear)
      Sidekiq::RetrySet.new.clear
      Sidekiq::ScheduledSet.new.clear
      Sidekiq::DeadSet.new.clear
      puts "Sidekiq queue is now empty!"
    end
  end
  