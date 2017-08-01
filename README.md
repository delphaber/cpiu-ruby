# CPIU

[![Build Status](https://travis-ci.org/clpo13/cpiu-ruby.svg?branch=master)](https://travis-ci.org/clpo13/cpiu-ruby)
[![Coverage Status](https://coveralls.io/repos/github/clpo13/cpiu-ruby/badge.svg?branch=master)](https://coveralls.io/github/clpo13/cpiu-ruby?branch=master)
[![Gem Version](https://badge.fury.io/rb/cpiu.svg)](https://badge.fury.io/rb/cpiu)

CPIU is a Ruby interface for [CPI-U](https://www.bls.gov/cpi/) data provided by the U.S. Bureau of Labor Statistics. CPI-U data are commonly used for calculating inflation. More info on the BLS Public Data API is available [here](https://www.bls.gov/developers/home.htm).

Neither I nor BLS.gov can vouch for the data or analyses derived from these data after the data have been retrieved from BLS.gov.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'cpiu', '~> 0.1'
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

This code is licensed under [GPLv3](LICENSE.txt).
