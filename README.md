# CPIU

CPIU is a Ruby interface for [CPI-U](https://www.bls.gov/cpi/) data provided by the U.S. Bureau of Labor Statistics. CPI-U data are commonly used for calculating inflation. More info on the BLS Public Data API is available [here](https://www.bls.gov/developers/home.htm).

Neither I nor BLS.gov can vouch for the data or analyses derived from these data after the data have been retrieved from BLS.gov.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'cpiu', '~> 0.1.0'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install ruby_cpiu

## Usage

Add the following to your program:

```ruby
require 'cpiu'
```

TODO: Write usage instructions here

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/clpo13/ruby_cpiu.

## License

This code is licensed under [GPLv3](LICENSE.txt).
