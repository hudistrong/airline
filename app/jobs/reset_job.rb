class ResetJob < ApplicationJob
  def perform(*args)
    puts "sidekiq 测试!"
    # Do something later
  end
end
