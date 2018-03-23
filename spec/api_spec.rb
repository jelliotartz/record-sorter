require "cuba/test"
require "./api/records.rb"

scope 'Record Parser' do
	test 'returns records sorted by gender (female first), last name ascending' do |params|
		get 'http://localhost:9393/records/gender'
		response = [
			"Berk,Samantha,Female,Red,10/5/1983\n",
			"Fonda,Jillian,Female,Purple,3/8/1966\n",
			"Johnson,Michelle,Female,Blue,12/5/1988\n",
			"Moore,Melissa,Female,Turquoise,7/3/1983\n",
			"Smith,Barbara,Female,Blue,3/6/1987\n",
			"Appleseed,Robert,Male,Green,2/4/1967\n",
			"Douglas,John,Male,Yellow,3/4/1995\n",
			"Grossman,Rex,Male,Orange,12/5/1987\n",
			"McCabe,Jonathan,Male,Turquoise,4/6/1987\n"
		]

		assert_equal response, JSON.parse(last_response.body)
	end

	test 'returns records sorted by birthdate, ascending' do |params|
		get 'http://localhost:9393/records/date_of_birth'
		response = [
			"Fonda,Jillian,Female,Purple,3/8/1966\n",
			"Appleseed,Robert,Male,Green,2/4/1967\n",
			"Moore,Melissa,Female,Turquoise,7/3/1983\n",
			"Berk,Samantha,Female,Red,10/5/1983\n",
			"Grossman,Rex,Male,Orange,12/5/1987\n",
			"Smith,Barbara,Female,Blue,3/6/1987\n",
			"McCabe,Jonathan,Male,Turquoise,4/6/1987\n",
			"Johnson,Michelle,Female,Blue,12/5/1988\n",
			"Douglas,John,Male,Yellow,3/4/1995\n"
		]

		assert_equal response, JSON.parse(last_response.body)
	end

	test 'returns records sorted by last name, descending' do |params|
		get 'http://localhost:9393/records/last_name'
		response = [
			"Smith,Barbara,Female,Blue,3/6/1987\n",
			"Moore,Melissa,Female,Turquoise,7/3/1983\n",
			"McCabe,Jonathan,Male,Turquoise,4/6/1987\n",
			"Johnson,Michelle,Female,Blue,12/5/1988\n",
			"Grossman,Rex,Male,Orange,12/5/1987\n",
			"Fonda,Jillian,Female,Purple,3/8/1966\n",
			"Douglas,John,Male,Yellow,3/4/1995\n",
			"Berk,Samantha,Female,Red,10/5/1983\n",
			"Appleseed,Robert,Male,Green,2/4/1967\n"
		]

		assert_equal response, JSON.parse(last_response.body)
	end
end
