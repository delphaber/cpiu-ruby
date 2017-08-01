# CPIU - a Ruby interface for fetching CPI-U data from BLS.gov
# Copyright (C) 2017 Cody Logan
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

require 'cpiu/api'

module CPIU
  # Return CPI data to the user while stripping the rest
  # of the response data returned by the server
  class Data
    # Get CPI data for a single year
    # @param year [Integer]
    # @return [Array<Hash>] an array of hashes containing monthly CPI values
    def self.single_year(year)
      response = CPIU::API.request_data(year, year)
      response['Results']['series'][0]['data']
    end

    # Get CPI data for a year range (up to 20 years)
    # @param startyear [Integer] the first year to get data for
    # @param endyear [Integer] the last year to get data for
    # @return [Array<Hash>] an array of hashes containing monthly CPI values
    def self.year_range(startyear, endyear)
      response = CPIU::API.request_data(startyear, endyear)
      response['Results']['series'][0]['data']
    end
  end
end
