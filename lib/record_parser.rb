require 'csv'

csv_file = ARGV[0]
space_file = ARGV[1]
pipe_file = ARGV[2]

def parse_files(csv_file, space_file, pipe_file)
	parsed_records = []
	parsed_records << parse_csv_files(csv_file)
	parsed_records << parse_space_files(space_file)
	parsed_records << parse_pipe_files(pipe_file)
	parsed_records
end

def parse_csv_files(file)
	# :converters removes whitespace from data
	parsed = CSV.read(
		file, 
		:converters => lambda {|f| f ? f.strip : nil}, 
		:write_headers => true, 
		:headers => ["LastName", "FirstName", "Gender", "FavoriteColor", "DateOfBirth"]
	)
end

def parse_space_files(file)
  parsed = CSV.read(
  	file,
  	col_sep: " ",
  	:write_headers => true,
  	:headers => ["LastName", "FirstName", "Gender", "FavoriteColor", "DateOfBirth"]
	)
end

def parse_pipe_files(file)
	# :converters removes whitespace from data
  parsed = CSV.read(
  	file,
  	col_sep: "|",
  	:converters => lambda {|f| f ? f.strip : nil},
  	:write_headers => true, :headers => ["LastName", "FirstName", "Gender", "FavoriteColor", "DateOfBirth"]
	)
end

puts parse_files(csv_file, space_file, pipe_file)
