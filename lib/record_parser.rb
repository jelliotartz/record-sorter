require 'csv'
require 'Date'

csv_file = ARGV[0]
ssv_file = ARGV[1]
psv_file = ARGV[2]
sort_param = ARGV[3]

CSV::Converters[:to_date] = lambda { |string| 
	begin
		Date.parse(string)
	rescue ArgumentError
		string
	end
}

CSV::Converters[:strip_white_space] = lambda { |string| string ? string.strip : nil }

def parse_files(csv_file, ssv_file, psv_file)
	parsed_records = parse_csv_file(csv_file)
	parsed_records.push(*parse_ssv_file(ssv_file))
	parsed_records.push(*parse_psv_file(psv_file))
end

def parse_csv_file(file)
	CSV.read(
		file, 
		:headers => true, 
		:converters => CSV::Converters.keys + [:strip_white_space] + [:to_date]
	)
end

def parse_ssv_file(file)
  parsed = CSV.read(
  	file,
  	col_sep: " ",
  	:headers => true,
  	:converters => CSV::Converters.keys + [:strip_white_space] + [:to_date]
	).to_a[1..-1]
end

def parse_psv_file(file)
  parsed = CSV.read(
  	file,
  	col_sep: "|",
  	:headers => true,
  	:converters => CSV::Converters.keys + [:strip_white_space] + [:to_date]
	).to_a[1..-1]
end

def sort_data(sort_param, records)
	case sort_param
	when "gender" then sorted = records.sort_by { |record| record.values_at('gender', 'last_name') }
	when "date_of_birth" then sorted = records.sort_by { |record| record['date_of_birth']	}
	when "last_name" then sorted = records.sort_by { |record| record.values_at('last_name') }
	else puts 'invalid sort parameter!'
	end

	sorted ? sorted.each { |record| p record } : nil
end

parsed_records = parse_files(csv_file, ssv_file, psv_file)
sort_data(sort_param, parsed_records)
