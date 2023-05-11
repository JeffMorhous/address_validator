class CLI
  def self.run(file_path)
    addresses = CSVFileReader.parse(file_path)
    response = AddressValidator.validate(addresses)
  end
end
