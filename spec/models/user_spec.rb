require 'rails_helper'

RSpec.describe User do
  describe 'Validations' do
    it { should validate_presence_of(:role) }
    it { should validate_presence_of(:username) }
    it { should validate_uniqueness_of(:username) }
    it { should validate_presence_of(:password) }
    it { should validate_confirmation_of(:password) }
    it { should validate_presence_of(:address) }
    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:last_name) }
  end

  describe 'Relationships' do
    it { should have_many(:orders) }
  end

  describe 'instance methods' do
    describe '.full_name' do
      it 'should return the users full name' do
        user = User.create!(username:'ex0rc1st',
                            password:'coolguy',
                            first_name:'John',
                            last_name:'Constantine',
                            role: 0,
                            address:'490 dark st')
        expect(user.full_name).to eq("#{user.first_name} #{user.last_name}")
      end
    end
  end
end
