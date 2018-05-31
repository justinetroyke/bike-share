require 'rails_helper'

RSpec.describe 'All Accessories on Dashboard (Admin)' do
  before :each do
    @admin = User.create!(username: 'admin', password: 'password', address: '123 admin street', first_name: 'John', last_name: 'Smith', role: 1)
    40.times do |n|
      Accessory.create(title: "Accessory #{n}", price: n, description: "This is accessory #{n}")
    end
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin)
    visit admin_dashboard_path
  end

  describe 'An admin visits the /admin/dashboard page' do
    it 'they should see their name at the top' do
      expect(page).to have_content("#{@admin.first_name}'s Dashboard")
    end
  end
end
