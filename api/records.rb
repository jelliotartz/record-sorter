require "cuba"
require "cuba/safe"
require "pry"
require "csv"
require_relative './../config/db_config'

Cuba.use Rack::Session::Cookie, :secret => "__a_very_long_string__"
Cuba.plugin Cuba::Safe

Cuba.define do
	records = CSV.read(DB_FILE_PATH, headers: true)

	on get, "records/:sort_parameter" do |sort_parameter|
		case sort_parameter
		when "gender" then sorted = records.sort_by { |record| record.values_at('gender', 'last_name') }
		when "date_of_birth" then sorted = records.sort_by { |record| record['date_of_birth']	}
		when "last_name" then sorted = records.sort_by { |record| record.values_at('last_name') }
		else puts 'invalid sort parameter!'
		end
		# formatted for readability. basic json reponse = res.write sorted.to_json
		res.write JSON.pretty_generate(sorted)
	end

	on post do
		on "records" do
			on param("last_name"), param("first_name"), param("gender"), param("favorite_color"), param("date_of_birth") do | last_name, first_name, gender, favorite_color, date_of_birth |
				records << [last_name, first_name, gender, favorite_color, date_of_birth]
				File.open(DB_FILE_PATH, "w") do |file|
					file.write(records)
				end
			end

      on true do
        res.write "You need to provide the correct parameters!"
      end
		end
	end
end
