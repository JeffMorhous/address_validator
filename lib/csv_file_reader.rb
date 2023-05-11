require 'csv'

class CSVFileReader
  def self.parse(file_path)
    csv_data = CSV.read(file_path, headers: true)
    csv_data.map do |row|
      # Strip out all whitespace, not just leading/trailing
      row.to_h.transform_keys { |key| key.gsub(/\s+/, '').downcase }
      .transform_values(&:strip)
    end
  end
end
