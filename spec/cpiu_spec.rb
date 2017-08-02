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
