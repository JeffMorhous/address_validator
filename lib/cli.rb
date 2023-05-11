# frozen_string_literal: true

# Handles I/O for the command line interface
class CLI
  def self.run(file_path)
    addresses = CSVFileReader.parse(file_path)
    validated_addresses = AddressValidator.validate(addresses)
    display_corrected_addresses(addresses, validated_addresses)
  end

  def self.display_corrected_addresses(uncorrected_addresses, corrected_addresses)
    uncorrected_addresses.zip(corrected_addresses).map do |uncorrected, corrected|
      puts "#{uncorrected['street']}, #{uncorrected['city']}, #{uncorrected['zipcode']} -> #{corrected}"
    end
  end
end
