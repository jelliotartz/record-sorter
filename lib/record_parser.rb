require 'csv'
require 'Date'
require 'pry'
require 'table_print'
require_relative './../config/db_config'

csv_file = RECORD_SEEDS_CSV_FILE_PATH
psv_file = RECORD_SEEDS_PSV_FILE_PATH
ssv_file = RECORD_SEEDS_SSV_FILE_PATH
sort_param = ARGV[0]

CSV::Converters[:to_date] = lambda { |string| 
	begin
		Date.parse(string).strftime('%-m/%-d/%Y')
	rescue ArgumentError
		string
	end
}

CSV::Converters[:strip_white_space] = lambda { |string| string ? string.strip : nil }

def parse_files(csv_file, ssv_file, psv_file)
	parsed_records = parse_with_header(csv_file, ",")
	parsed_records.push(*parse_without_header(ssv_file, " "))
	parsed_records.push(*parse_without_header(psv_file, "|"))
end

def parse_with_header(file, delimiter)
	CSV.read(
		file, 
		col_sep: delimiter,
		:headers => true, 
		:converters => CSV::Converters.keys + [:strip_white_space] + [:to_date]
	)
end

def parse_without_header(file, delimiter)
	parse_with_header(file, delimiter).to_a[1..-1]
end

def sort_data(sort_param, records)
	case sort_param
	when "gender" then sorted = records.sort_by { |record| record.values_at('gender', 'last_name') }
	when "date_of_birth" then sorted = records.sort_by { |record| Date.parse(record['date_of_birth'])	}
	when "last_name" then sorted = records.sort_by { |record| record.values_at('last_name') }.reverse
	else puts 'invalid sort parameter!'
	end
end
