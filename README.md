# CPIU

[![Build Status](https://travis-ci.org/clpo13/cpiu-ruby.svg?branch=master)](https://travis-ci.org/clpo13/cpiu-ruby)
[![Coverage Status](https://coveralls.io/repos/github/clpo13/cpiu-ruby/badge.svg?branch=master)](https://coveralls.io/github/clpo13/cpiu-ruby?branch=master)
[![Gem Version](https://badge.fury.io/rb/cpiu.svg)](https://badge.fury.io/rb/cpiu)

CPIU is a Ruby interface for [CPI-U](https://www.bls.gov/cpi/) data provided by the U.S. Bureau of Labor Statistics. CPI-U data are commonly used for calculating inflation. More info on the BLS Public Data API is available [here](https://www.bls.gov/developers/home.htm).

Neither I nor BLS.gov can vouch for the data or analyses derived from these data after the data have been retrieved from BLS.gov.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'cpiu', '~> 0.2'
```

And then execute:

```bash
bundle
```

Or install it yourself as:

```bash
gem install cpiu
```

## Usage

Add the following to your program:

```ruby
require 'cpiu'
```

In order to get the most out of the BLS API, you will need a registration key, which can be obtained [here](https://data.bls.gov/registrationEngine/). Create a file named `.env` in the root of your project folder with the contents `BLS_API_KEY=<your key here>`. The API can still be queried without a key, but there are [restrictions](https://www.bls.gov/developers/api_faqs.htm#register1) on what data will be returned.

The following methods will retrieve JSON objects containing CPI-U data:

* `CPIU::Data.single_year(year)` - data for a single year
* `CPIU::Data.year_range(startyear, endyear)` - data for a year range no greater than 20 years

The data is returned in an array of hashes:

```ruby
[
  {
    "year" => "1913",
    "period" => "M12",
    "periodName" => "December",
    "value" => "10.0",
    "footnotes" => [{}]
  },
  ...
]
```

If you just want CPI-U values:

* `CPIU::Data.cpiu_year(year)` - the annual average CPI value for a year
* `CPIU::Data.cpiu_month(year, month)` - the CPI value for a particular month

A raw API call method is available too:

* `CPIU::API.request_data(startyear, endyear, ann_avg, calcs)`

If set to `true`, `ann_avg` will return the average CPI value for each year, and `calcs` will return net and percent changes in CPI. This method returns all response data in the form of a hash:

```ruby
{
  "status" => "REQUEST_SUCCEEDED",
  "responseTime" => 34,
  "message" => [],
  "Results" => {
    "series" => [
      {
        "seriesID" => "CUUR0000SA0",
        "data" => [
          {
            "year" => "1913",
            "period" => "M13",
            "periodName" => "Annual",
            "value" => "9.9",
            "footnotes" => [{}],
            "calculations" => {
              "net_changes" => {},
              "pct_changes" => {
                "1" => "-1.0",
                "3" => "-1.0",
                "6" => "0.0"
              }
            }
          },
          ...
        ]
      }
    ]
  }
}
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

### TODO

* [ ] Handle API errors

## Contributing

Bug reports and pull requests are welcome on GitHub at <https://github.com/clpo13/ruby_cpiu>.

## License

Copyright &copy; 2017 Cody Logan

This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

A copy of the GNU General Public License can be found in [LICENSE.txt](LICENSE.txt) and at <http://www.gnu.org/licenses/>.
