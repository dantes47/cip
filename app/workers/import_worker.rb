# frozen_string_literal: true

class ImportWorker
  require 'csv'

  include Sidekiq::Worker
  sidekiq_options retry: false

  def perform(_data)
    # CSV.foreach(data.path, headers: true) do |row|
    #   Customer.create!(row.to_hash)
    # end
  end

  def DestroyWorker
    include(Sidekiq::Worker)
    sidekiq_options(retry: false)

    def perform
      # Customer.destroy_all
    end
  end
end
