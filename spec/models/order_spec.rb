require 'rails_helper'

RSpec.describe Order do
  describe 'Validations' do
    it { should validate_presence_of(:status) }
    it { should validate_presence_of(:quantity) }
  end

  describe 'Relationships' do
    it { should belong_to(:user) }
    it { should have_many(:order_items)}
    it { should have_many(:items)}
  end
end
