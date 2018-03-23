# Record Sorter challenge

## Setup
To run the command line application:
- clone repo
- `bundle` to install Ruby gems
- `shotgun config.ru` to start server
- to print records to console: `ruby runner.rb <sort_parameter>`
- to execute GET and POST requests to REST API:
  - `curl -i -H "accept: application/json" -H "Content-Type: application/json" -X GET http://localhost:9393/records/<SortParameter>`
  - `curl --data "last_name=Ferguson&first_name=Bill&gender=Male&favorite_color=Blue&date_of_birth=3/16/1982" http://localhost:9393/records`
- tests: `ruby spec/api_spec.rb && ruby spec/record_parser_spec.rb`

## Tools used
- I chose to write this application in Ruby, because I am familiar with Ruby's CSV library and I like the tools available for manipulating CSV data.
- I used the [Cuba](https://github.com/soveran/cuba) microframework to build the standalone REST API, which includes a testing suite [cutest](https://github.com/djanowski/cutest).
- I used Ruby's [Tableprint gem](https://github.com/arches/table_print) to display the command line output in a readable format.

Thank you for the opportunity to complete this challenge, I enjoyed working on it and look forward to discussing my design choices and implementation with your team!

## Screenshots
![Print records to console (here sorted by DOB) using [Tableprint gem](https://github.com/arches/table_print)](/public/images/table-print-sorted.png)
Print records to console (here sorted by DOB) using [Tableprint gem](https://github.com/arches/table_print)
<br><br>
![GET and POST requests to REST API](/public/images/api-get-and-post.png)
GET and POST requests to REST API