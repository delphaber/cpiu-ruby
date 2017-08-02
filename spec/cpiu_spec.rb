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

require 'spec_helper'

RSpec.describe CPIU do
  it 'has a version number' do
    expect(CPIU::VERSION).not_to be nil
  end
end

RSpec.describe CPIU::API do
  it 'has the correct URL' do
    expect(CPIU::API::URL).to eql('https://api.bls.gov/publicAPI/v2/timeseries/data/')
  end

  it 'has the correct series ID' do
    expect(CPIU::API::SERIESID).to eql('CUUR0000SA0')
  end
end

RSpec.describe CPIU::Data do
  context 'when getting data for a single year' do
    it 'should return an array with exactly thirteen elements' do
      # one element for each month plus one annual
      VCR.use_cassette('single_year') do
        response = CPIU::Data.single_year(1913)
        expect(response.length).to eql(13)
      end
    end
  end

  context 'when getting data for a range of years' do
    it 'should return an array with more than thirteen elements' do
      VCR.use_cassette('year_range') do
        response = CPIU::Data.year_range(1913, 1914)
        expect(response.length).to be > 13
      end
    end
  end

  context 'when getting annual average CPI' do
    it 'should be a Float' do
      VCR.use_cassette('single_year') do
        cpi = CPIU::Data.cpiu_year(1913)
        expect(cpi).to be_a(Float)
      end
    end
  end

  context 'when getting a month\'s CPI' do
    it 'should be a Float' do
      VCR.use_cassette('single_year') do
        cpi = CPIU::Data.cpiu_month(1913, 5)
        expect(cpi).to be_a(Float)
      end
    end
  end
end
