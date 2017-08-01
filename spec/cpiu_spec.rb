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

  context 'when getting data for a single year' do
    it 'should return an array with a single element'
  end

  context 'when getting data for a range of years' do
    it 'should return an array with multiple elements'
  end
end
