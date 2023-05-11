# frozen_string_literal: true

require 'rspec'
require_relative '../../lib/cli'
require_relative '../../lib/address_validator'
require_relative '../../lib/csv_file_reader'

# rubocop:disable Metrics/BlockLength
describe CLI do
  describe '.run' do
    it 'reads, validates, and displays addresses' do
      file_path = 'spec/fixtures/test_file.csv' # We don't actually read the file here, since CSVFileReader is mocked

      addresses = [
        { 'street' => '143 e Maine Street', 'city' => 'Columbus', 'zipcode' => '43215' },
        { 'street' => '1 Empora St', 'city' => 'Title', 'zipcode' => '11111' },
        { 'street' => '800 N High St Suite 4-128', 'city' => 'Columbus', 'zipcode' => '43215' }
      ]

      validated_addresses = [
        '143 E Main St, Columbus 43215-5370',
        'Invalid Address',
        '800 N High St Ste 4-128, Columbus 43215-1430'
      ]

      # Stub CSVFileReader.parse and AddressValidator.validate
      allow(CSVFileReader).to receive(:parse).and_return(addresses)
      allow(AddressValidator).to receive(:validate).and_return(validated_addresses)

      # Expect display_corrected_addresses to be called with the correct arguments
      expect(CLI).to receive(:display_corrected_addresses).with(addresses, validated_addresses)

      CLI.run(file_path)
    end
  end

  describe '.display_corrected_addresses' do
    it 'displays the the uncorrected addresses with the corrected addresses' do
      uncorrected_addresses = [
        { 'street' => '143 e Maine Street', 'city' => 'Columbus', 'zipcode' => '43215' },
        { 'street' => '1 Empora St', 'city' => 'Title', 'zipcode' => '11111' },
        { 'street' => '800 N High St Suite 4-128', 'city' => 'Columbus', 'zipcode' => '43215' }
      ]

      corrected_addresses = [
        '143 E Main St, Columbus 43215-5370',
        'Invalid Address',
        '800 N High St Ste 4-128, Columbus 43215-1430'
      ]

      expected_output = [
        "143 e Maine Street, Columbus, 43215 -> 143 E Main St, Columbus 43215-5370\n",
        "1 Empora St, Title, 11111 -> Invalid Address\n",
        "800 N High St Suite 4-128, Columbus, 43215 -> 800 N High St Ste 4-128, Columbus 43215-1430\n"
      ]

      expect { CLI.display_corrected_addresses(uncorrected_addresses, corrected_addresses) }
        .to output(expected_output.join).to_stdout
    end
  end
end
# rubocop:enable Metrics/BlockLength
