# frozen_string_literal: true

require 'csv_file_reader'

RSpec.describe CSVFileReader, type: :model do
  describe '.parse' do
    let(:file_path) { 'spec/fixtures/test_file.csv' }
    let(:parsed_data) { CSVFileReader.parse(file_path) }

    it 'reads the csv file and returns formatted data as a hash' do
      expected_data = [
        { 'street' => '143 e Maine Street', 'city' => 'Columbus', 'zipcode' => '43215' },
        { 'street' => '1 Empora St', 'city' => 'Title', 'zipcode' => '11111' },
        { 'street' => '800 N High St Suite 4-128', 'city' => 'Columbus', 'zipcode' => '43215' }
      ]

      expect(parsed_data).to eq(expected_data)
    end
  end
end
