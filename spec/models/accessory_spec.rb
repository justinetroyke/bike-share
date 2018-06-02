require 'rails_helper'

RSpec.describe Accessory do
  describe 'Validations' do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:price) }
    it { should validate_numericality_of(:price).is_greater_than(0) }
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:status) }
    it { should validate_inclusion_of(:status).in_array([0, 1]) }
    it { should validate_presence_of(:image_url) }
  end

  describe 'Relationships' do
    it { should have_many(:order_accessories) }
    it { should have_many(:orders) }
  end
end
