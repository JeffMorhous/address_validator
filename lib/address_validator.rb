require 'httparty'

class AddressValidator
  include HTTParty

  BASE_URI = 'https://us-street.api.smartystreets.com/street-address'.freeze

  def self.validate(addresses)
    exit unless env_vars_present?
    
    query_url = "#{BASE_URI}?auth-id=#{ENV['AUTH_ID']}&auth-token=#{ENV['AUTH_TOKEN']}&license=#{ENV['LICENSE']}"
    
    response = HTTParty.post query_url,
                            body: addresses.to_json

    if response.code == "200"
      puts "SUCCESS!"
      puts response
    else
      puts response.code
      return "Problem with API"
    end
  end

  private

  def self.env_vars_present?
    required_env_vars = ['AUTH_ID', 'AUTH_TOKEN', 'LICENSE']

    missing_env_vars = required_env_vars.select { |var| ENV[var].nil? || ENV[var].empty? }

    unless missing_env_vars.empty?
      puts "Missing required environment variables: #{missing_env_vars.join(', ')}"
      return false
    end
    
    return true
  end
end
