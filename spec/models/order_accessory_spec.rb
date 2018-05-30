require 'rails_helper'

RSpec.describe OrderAccessory do
  describe 'Relationships' do
    it { should belong_to(:order) }
    it { should belong_to(:accessory) }
  end
end
