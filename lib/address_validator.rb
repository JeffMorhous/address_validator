# frozen_string_literal: true

require 'httparty'

# Validates addresses. Expects an array of addresses, properly formatted.
class AddressValidator
  include HTTParty

  QUERY_URL = "https://us-street.api.smartystreets.com/street-address?auth-id=#{ENV['AUTH_ID']}&auth-token=#{ENV['AUTH_TOKEN']}&license=#{ENV['LICENSE']}"

  def self.validate(addresses)
    exit unless env_vars_present?

    response = HTTParty.post QUERY_URL,
                             body: addresses.to_json

    if response.code == 200
      parse(response.body, addresses.size)
    else
      puts 'There was a problem connecting with the API'
      return []
    end
  end

  def self.env_vars_present?
    required_env_vars = %w[AUTH_ID AUTH_TOKEN LICENSE]

    missing_env_vars = required_env_vars.select { |var| ENV[var].nil? || ENV[var].empty? }

    unless missing_env_vars.empty?
      puts "Missing required environment variables: #{missing_env_vars.join(', ')}"
      return false
    end

    true
  end

  def self.parse(response, number_of_inputs)
    addresses = Array.new(number_of_inputs, 'Invalid Address')
    parsed_response = JSON.parse(response)

    parsed_response.each do |item|
      index = item['input_index']
      address = format_address(item)

      addresses[index] = address
    end

    addresses
  end

  def self.format_address(item)
    delivery_line1 = item['delivery_line_1']
    city = item['components']['city_name']
    zipcode = item['components']['zipcode']
    plus4_code = item['components']['plus4_code']

    "#{delivery_line1}, #{city} #{zipcode}-#{plus4_code}"
  end
end
