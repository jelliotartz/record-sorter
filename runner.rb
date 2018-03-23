require_relative 'lib/record_parser'
require_relative 'config/db_config'
require 'table_print'

sort_param = ARGV[0]
csv_file = RECORD_SEEDS_CSV_FILE_PATH
psv_file = RECORD_SEEDS_PSV_FILE_PATH
ssv_file = RECORD_SEEDS_SSV_FILE_PATH

def display(sorted_data)
	tp sorted_data.map(&:to_h), :last_name, :first_name, :gender, :favorite_color, date_of_birth: lambda { |record| record['date_of_birth'] }
end

def save(records)
	File.open(DB_FILE_PATH, "w") do |file|
		file.write(records)
	end
end

parsed_records = parse_files(csv_file, ssv_file, psv_file)
save(parsed_records)
sorted_data = sort_data(sort_param, parsed_records)
display(sorted_data)
