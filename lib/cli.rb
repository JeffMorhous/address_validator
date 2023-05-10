class CLI
  def self.run(file_path)
    addresses = CSVFileReader.read(file_path)

    addresses.each do |address|
      formatted_address = "#{address['Street']}, #{address['City']}, #{address['Zip Code']}"
      puts formatted_address

    end
  end
end
