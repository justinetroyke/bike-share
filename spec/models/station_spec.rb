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
end
