require "cuba/test"
require "./lib/record_parser.rb"
require_relative './../config/db_config'
require "csv"

scope 'Record Parser' do
	data = CSV.read(DB_FILE_PATH, headers: true)

	test 'returns records sorted by gender (female first), last name ascending' do |params|
		response = [ 
			{"last_name"=>"Berk", "first_name"=>"Samantha", "gender"=>"Female", "favorite_color"=>"Red", "date_of_birth"=>"10/5/1983"},
			{"last_name"=>"Fonda", "first_name"=>"Jillian", "gender"=>"Female", "favorite_color"=>"Purple", "date_of_birth"=>"3/8/1966"},
			{"last_name"=>"Johnson", "first_name"=>"Michelle", "gender"=>"Female", "favorite_color"=>"Blue", "date_of_birth"=>"12/5/1988"},
			{"last_name"=>"Moore", "first_name"=>"Melissa", "gender"=>"Female", "favorite_color"=>"Turquoise", "date_of_birth"=>"7/3/1983"},
			{"last_name"=>"Smith", "first_name"=>"Barbara", "gender"=>"Female", "favorite_color"=>"Blue", "date_of_birth"=>"3/6/1987"},
			{"last_name"=>"Appleseed", "first_name"=>"Robert", "gender"=>"Male", "favorite_color"=>"Green", "date_of_birth"=>"2/4/1967"},
			{"last_name"=>"Douglas", "first_name"=>"John", "gender"=>"Male", "favorite_color"=>"Yellow", "date_of_birth"=>"3/4/1995"},
			{"last_name"=>"Grossman", "first_name"=>"Rex", "gender"=>"Male", "favorite_color"=>"Orange", "date_of_birth"=>"12/5/1987"},
			{"last_name"=>"McCabe", "first_name"=>"Jonathan", "gender"=>"Male", "favorite_color"=>"Turquoise", "date_of_birth"=>"4/6/1987"}
		]

		sorted_data = sort_data("gender", data)
		assert_equal sorted_data.map(&:to_h), response
	end

	test 'returns records sorted by birthdate, ascending' do |params|
		response = [
			{"last_name"=>"Fonda", "first_name"=>"Jillian", "gender"=>"Female", "favorite_color"=>"Purple", "date_of_birth"=>"3/8/1966"},
			{"last_name"=>"Appleseed", "first_name"=>"Robert", "gender"=>"Male", "favorite_color"=>"Green", "date_of_birth"=>"2/4/1967"},
			{"last_name"=>"Moore", "first_name"=>"Melissa", "gender"=>"Female", "favorite_color"=>"Turquoise", "date_of_birth"=>"7/3/1983"},
			{"last_name"=>"Berk", "first_name"=>"Samantha", "gender"=>"Female", "favorite_color"=>"Red", "date_of_birth"=>"10/5/1983"},
			{"last_name"=>"Grossman", "first_name"=>"Rex", "gender"=>"Male", "favorite_color"=>"Orange", "date_of_birth"=>"12/5/1987"},
			{"last_name"=>"Smith", "first_name"=>"Barbara", "gender"=>"Female", "favorite_color"=>"Blue", "date_of_birth"=>"3/6/1987"},
			{"last_name"=>"McCabe", "first_name"=>"Jonathan", "gender"=>"Male", "favorite_color"=>"Turquoise", "date_of_birth"=>"4/6/1987"},
			{"last_name"=>"Johnson", "first_name"=>"Michelle", "gender"=>"Female", "favorite_color"=>"Blue", "date_of_birth"=>"12/5/1988"},
			{"last_name"=>"Douglas", "first_name"=>"John", "gender"=>"Male", "favorite_color"=>"Yellow", "date_of_birth"=>"3/4/1995"}
		]

		sorted_data = sort_data("date_of_birth", data)
		assert_equal sorted_data.map(&:to_h), response
	end

	test 'returns records sorted by last name, descending' do |params|
		response = [
			{"last_name"=>"Smith", "first_name"=>"Barbara", "gender"=>"Female", "favorite_color"=>"Blue", "date_of_birth"=>"3/6/1987"},
			{"last_name"=>"Moore", "first_name"=>"Melissa", "gender"=>"Female", "favorite_color"=>"Turquoise", "date_of_birth"=>"7/3/1983"},
			{"last_name"=>"McCabe", "first_name"=>"Jonathan", "gender"=>"Male", "favorite_color"=>"Turquoise", "date_of_birth"=>"4/6/1987"},
			{"last_name"=>"Johnson", "first_name"=>"Michelle", "gender"=>"Female", "favorite_color"=>"Blue", "date_of_birth"=>"12/5/1988"},
			{"last_name"=>"Grossman", "first_name"=>"Rex", "gender"=>"Male", "favorite_color"=>"Orange", "date_of_birth"=>"12/5/1987"},
			{"last_name"=>"Fonda", "first_name"=>"Jillian", "gender"=>"Female", "favorite_color"=>"Purple", "date_of_birth"=>"3/8/1966"},
			{"last_name"=>"Douglas", "first_name"=>"John", "gender"=>"Male", "favorite_color"=>"Yellow", "date_of_birth"=>"3/4/1995"},
			{"last_name"=>"Berk", "first_name"=>"Samantha", "gender"=>"Female", "favorite_color"=>"Red", "date_of_birth"=>"10/5/1983"},
			{"last_name"=>"Appleseed", "first_name"=>"Robert", "gender"=>"Male", "favorite_color"=>"Green", "date_of_birth"=>"2/4/1967"}
		]

		sorted_data = sort_data("last_name", data)
		assert_equal sorted_data.map(&:to_h), response
	end

	test 'displays dates in the correct format' do |params|
		date_of_birth = data[0]['date_of_birth']
		assert_equal date_of_birth, "12/5/1987"
	end
end