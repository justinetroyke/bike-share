require 'rails_helper'

RSpec.describe Accessory do
  describe 'Validations' do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:price) }
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:image_url) }
  end

  describe 'Relationships' do
    it { should have_many(:order_accessories) }
    it { should have_many(:orders) }
  end
end
