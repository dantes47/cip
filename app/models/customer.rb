# frozen_string_literal: true

class Customer < ApplicationRecord
  def self.import(data)
    CSV.foreach(data.path, headers: true) do |row|
      Customer.create!(row.to_hash)
    end
  end
end
