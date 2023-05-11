# frozen_string_literal: true

require 'address_validator'
require 'webmock/rspec'
# rubocop:disable Metrics/BlockLength
RSpec.describe AddressValidator, type: :model do
  describe '.validate' do
    let(:addresses) do
      [
        { 'street' => '143 e Maine Street', 'city' => 'Columbus', 'zipcode' => '43215' },
        { 'street' => '1 Empora St', 'city' => 'Title', 'zipcode' => '11111' }
      ]
    end

    context 'when the response is successful' do
      before do
        stub_request(:post, AddressValidator::QUERY_URL)
          .with(body: addresses.to_json)
          .to_return(status: 200, body: response_body)
      end
      let(:response_body) do
        [
          {
            'input_index' => 0,
            'candidate_index' => 0,
            'delivery_line_1' => '143 E Main St',
            'last_line' => 'Columbus OH 43215-5370',
            'components' => {
              'city_name' => 'Columbus',
              'zipcode' => '43215',
              'plus4_code' => '5370'
            }
          },
          {
            'input_index' => 1,
            'candidate_index' => 0,
            'delivery_line_1' => '1 Empora St',
            'last_line' => 'Title 11111-0000',
            'components' => {
              'city_name' => 'Title',
              'zipcode' => '11111',
              'plus4_code' => '0000'
            }
          }
        ].to_json
      end

      it 'returns the corrected addresses' do
        expected_result = [
          '143 E Main St, Columbus 43215-5370',
          '1 Empora St, Title 11111-0000'
        ]

        expect(AddressValidator.validate(addresses)).to eq(expected_result)
      end
    end

    context 'when the response is unsuccessful' do
      before do
        stub_request(:post, AddressValidator::QUERY_URL)
          .with(body: addresses.to_json)
          .to_return(status: 400, body: response_body)
      end
      let(:response_body) { [].to_json }

      it 'returns an empty array' do
        expect(AddressValidator.validate(addresses)).to eq([])
      end

      it 'outputs an error message to the console' do
        expect do
          AddressValidator.validate(addresses)
        end.to output("There was a problem connecting with the API\n").to_stdout
      end
    end
  end
end
# rubocop:enable Metrics/BlockLength
