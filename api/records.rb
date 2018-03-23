require "cuba"
require "cuba/safe"
require "pry"
require "csv"
require_relative './../config/db_config'
require_relative './../lib/record_parser'

Cuba.use Rack::Session::Cookie, :secret => "__a_very_long_string__"
Cuba.plugin Cuba::Safe

Cuba.define do
	records = CSV.read(DB_FILE_PATH, headers: true)

	on get, "records/:sort_parameter" do |sort_parameter|
		sorted = sort_data(sort_parameter, records)

		# res.write JSON.pretty_generate(sorted)
		res.write sorted.to_json
	end

	on post do
		on "records" do
			on param("last_name"), param("first_name"), param("gender"), param("favorite_color"), param("date_of_birth") do | last_name, first_name, gender, favorite_color, date_of_birth |
				records << [last_name, first_name, gender, favorite_color, date_of_birth]
				File.open(DB_FILE_PATH, "w") do |file|
					file.write(records)
				end
			end

			# If the correct params are not provided, this block will get executed.
      on true do
        res.write "You need to provide the correct parameters!"
      end
		end
	end
end
