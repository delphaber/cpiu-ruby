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
require 'ruby_cpiu'

module RubyCPIU
  class API

    # Pulls CPI-U data from the BLS server given two years between
    # 1913 and the present with a maximum range of 20 years.
    #
    # @param startyear [Integer] the first year to get data for
    # @param endyear [Integer] the last year to get data for
    # @return [JSON] the response data retrieved from the server
    def self.get_data(startyear, endyear)

      url = 'https://api.bls.gov/publicAPI/v2/timeseries/data/'
      seriesid = 'CUUR0000SA0'

      response = RestClient.post(url,
                                 {'seriesid'  => [seriesid],
                                  'startyear' => startyear,
                                  'endyear'   => endyear,
                                  'annualaverage' => true,
                                  'registrationkey' => ENV['BLS_API_KEY']
                                 }.to_json,
                                 :content_type => 'application/json')
      JSON(response)
    end
  end
end
