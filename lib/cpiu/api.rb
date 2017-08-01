# frozen_string_literal: true

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

require 'rest-client'
require 'json'
require 'dotenv/load'

module CPIU
  # Interacts with the BLS.gov public API
  class API
    # URL to send POST requests to
    URL = 'https://api.bls.gov/publicAPI/v2/timeseries/data/'.freeze
    # The time series to query
    SERIESID = 'CUUR0000SA0'.freeze

    # Requests CPI-U data from the BLS server given two years between 1913 and the
    # present. The API will only return a maximum range of 20 years from the start year.
    #
    # @param startyear [Integer] the first year to get data for
    # @param endyear [Integer] the last year to get data for
    # @param ann_avg [Boolean] set to true to include the average of monthly CPI values for a year
    # @param calcs [Boolean] set to true to include net and percent CPI change calculations
    # @return [Hash{String => String, Integer, Array}] the response data retrieved from the server
    def self.request_data(startyear, endyear, ann_avg = false, calcs = false)
      response = RestClient.post(URL,
                                 {
                                   'seriesid'        => [SERIESID],
                                   'startyear'       => startyear,
                                   'endyear'         => endyear,
                                   'annualaverage'   => ann_avg,
                                   'calculations'    => calcs,
                                   'registrationkey' => ENV['BLS_API_KEY']
                                 }.to_json,
                                 content_type: 'application/json')
      JSON(response)
    end
  end
end
