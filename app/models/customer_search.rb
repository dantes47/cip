# frozen_string_literal: true

class CustomerSearch
  attr_reader :date_from, :date_to

  def initialize(prms)
    prms ||= {}

    @date_from = parsed_date(prms[:date_from], 5.days.ago.to_date.to_s)
    @date_to = parsed_date(prms[:date_to], Time.zone.today.to_s)
  end

  def scope
    Customer.where('date BETWEEN ? AND ?', @date_from, @date_to)
  end

  private

  def parsed_date(date_str, default)
    Date.parse(date_str)
  rescue ArgumentError, TypeError
    default
  end
end
