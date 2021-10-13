# frozen_string_literal: true

class ImportWorker
  include Sidekiq::Worker
  sidekiq_options retry: false

  def perform(data)
    # CSV.foreach(data.path, headers: true) do |row|
    #   Customer.create!(row.to_hash)
    # end
  end

  def DestroyWorker
    include Sidekiq::Worker
    sidekiq_options retry: false

    def perform
      # Customer.destroy_all
    end
  end
end
