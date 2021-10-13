# frozen_string_literal: true

class ExportWorker
  include Sidekiq::Worker

  def perform(*_args)
    # Do something
  end
end
