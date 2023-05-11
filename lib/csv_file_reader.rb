# frozen_string_literal: true

require 'csv'

# Parses a CSV file, formatting the resulting array with properly named keys.
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
