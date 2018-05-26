require 'rails_helper'

RSpec.describe Item do
  describe 'Validations' do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:price) }
    it { should validate_presence_of(:description) }
  end

  describe 'Relationships' do
    it { should have_many(:order_items) }
    it { should have_many(:orders) }
  end
end
