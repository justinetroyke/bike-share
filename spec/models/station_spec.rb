require 'rails_helper'

RSpec.describe Station do
  describe 'Validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:dock_count) }
    it { should validate_presence_of(:city) }
    it { should validate_presence_of(:installation_date) }
  end

  describe 'Relationships' do
    it { is_expected.to have_many(:start_trips) }
    it { is_expected.to have_many(:end_trips) }
  end

  describe 'Insatance Methods' do
    describe '#generate_slug' do
      it 'should create a slug out of the station name' do
        station1 = Station.new(name: 'Station Name',
                               dock_count: 12,
                               city: 'Denver',
                               installation_date: '2015-01-02',
                               slug: nil)

        station1.generate_slug

        expect(station1.slug).to eq(station1.name.parameterize)
      end
    end
  end
end
