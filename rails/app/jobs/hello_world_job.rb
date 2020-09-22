# app/jobs/hello_world_job.rb
class HelloWorldJob < ApplicationJob
  queue_as :default

  def perform(*args)
    p "hello from HelloWorldJob #{Aid.count}"
  end

end
