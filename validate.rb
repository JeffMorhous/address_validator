require_relative 'lib/csv_file_reader'
require_relative 'lib/address_validator'
require_relative 'lib/cli'

# TODO: Take filepath from args
CLI.run('filepath.csv')
