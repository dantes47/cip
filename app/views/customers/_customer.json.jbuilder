# frozen_string_literal: true

json.extract!(customer, :id, :first_name, :last_name, :email, :date_of_birth, :created_at, :updated_at)
json.url(customer_url(customer, format: :json))
