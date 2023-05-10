require 'csv'

class CSVFileReader
  def self.parse(file_path)
    csv_data = CSV.read(file_path, headers: true)
    csv_data.map do |row|
      row.to_h.transform_keys(&:strip).transform_values(&:strip)
    end
  end
end
