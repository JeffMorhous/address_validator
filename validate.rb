require_relative 'lib/csv_file_reader'
require_relative 'lib/address_validator'
require_relative 'lib/cli'

file_path = ARGV[0]

if file_path.nil?
  puts "Please provide a CSV file path."
  exit
end

CLI.run(file_path)
