# frozen_string_literal: true

class Customer < ApplicationRecord
  # validates :first_name, presence: true
  # validates :last_name, presence: true
  # validates :date_of_birth, presence: true
  # validates :email, presence: true, uniqueness: true

  # export CSV
  def self.to_csv(fields = column_names, opts = {})
    CSV.generate(opts) do |csv|
      csv << fields
      all.find_each do |customer|
        csv << customer.attributes.values_at(*fields)
      end
    end
  end

  # import CSV
  def self.import(data)
    CSV.foreach(data.path, headers: true) do |row|
      hashed_data = row.to_hash

      customer = find_or_create_by!(
        first_name: hashed_data['first_name'],
        last_name: hashed_data['last_name'],
        email: hashed_data['email'],
        date_of_birth: hashed_data['date_of_birth']
      )

      customer.update!(hashed_data)
    end
  rescue StandardError => err
    Rails.logger.debug(err.message) # rescue, in case - user/admin will deside to push empty dataset.
  end
end
