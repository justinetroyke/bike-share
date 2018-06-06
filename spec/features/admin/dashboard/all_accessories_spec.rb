require 'rails_helper'

RSpec.describe 'All Accessories on Dashboard (Admin)' do
  before :each do
    @admin = User.create!(username: 'admin', password: 'password', address: '123 admin street', first_name: 'John', last_name: 'Smith', role: 1)
    @accessories = []
    40.times do |n|
      @accessories << Accessory.create!(title: "Accessory #{n}", price: n+1, description: "This is accessory #{n}")
    end
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin)
    visit admin_dashboard_path
  end

  describe 'An admin visits the /admin/dashboard page' do
    it 'they should see their name at the top' do
      expect(page).to have_content("#{@admin.first_name}'s Dashboard")
    end

    it 'they should see a link for viewing all accessories' do
      expect(page).to have_link('View All Accessories')
    end

    it 'should take them to the /admin/bike-shop page where all accessories are visible' do
      click_link 'View All Accessories'
      expect(page).to have_current_path(admin_accessories_path)
      @accessories.each do |accessory|
        within("#accessory-#{accessory.id}") do
          expect(page.find('.thumbnail')['src']).to have_content(accessory.image_url)
          expect(page).to have_content(accessory.title)
          expect(page).to have_content(accessory.description)
          expect(page).to have_content(accessory.status.capitalize)
          expect(page).to have_link('Edit')
          expect(page).to have_button('Retire')
        end
      end
    end
  
    it 'clicking edit should take the admin to the edit page for that accessory' do
      click_link 'View All Accessories'
      @accessories.each do |accessory|
        within("#accessory-#{accessory.id}") do
          click_link 'Edit'
          expect(page).to have_current_path(edit_admin_accessory_path(accessory))
          visit admin_accessories_path
        end
      end
    end

    it 'should be able to edit an accessory' do
      click_link 'View All Accessories'

      edited_title = 'Edited Title'
      edited_description = 'This is an edited description'
      edited_price = 1.45

      within("#accessory-#{@accessories[0].id}") do
        click_link 'Edit'
      end
      
      expect(page).to have_current_path(edit_admin_accessory_path(@accessories[0]))

      fill_in 'accessory[title]', with: edited_title
      fill_in 'accessory[description]', with: edited_description
      fill_in 'accessory[price]', with: edited_price
      click_button 'Update Accessory'

      expect(page).to have_current_path(accessory_path(@accessories[0]))
      expect(page).to have_content("Title:\n#{edited_title}")
      expect(page).to have_content("Description:\n#{edited_description}")
      expect(page).to have_content("Price:\n$#{edited_price}")

      expect(page).to_not have_content("Title: #{@accessories[0].title}")
      expect(page).to_not have_content("Description: #{@accessories[0].description}")
      expect(page).to_not have_content("Price: #{@accessories[0].price}")
    end
  end

  it 'clicking the \'Retire\' button should change the accessory\'s status and reload the page' do
    click_link 'View All Accessories'
    within("#accessory-#{@accessories[0].id}") do
      click_button 'Retire'
    end
    expect(page).to have_current_path(admin_accessories_path)
    expect(Accessory.find(@accessories[0].id).status).to eq('inactive')
    within("#accessory-#{@accessories[0].id}") do
      expect(page).to have_content('Inactive')
    end
  end

  it 'clicking the \'Reactivate\' button should activate an inactive accessory' do
    @accessories[3].update!(status: 'inactive')
    click_link 'View All Accessories'

    within("#accessory-#{@accessories[3].id}") do
      expect(page).to have_content('Inactive')
      click_button 'Reactivate'
    end

    expect(page).to have_current_path(admin_accessories_path)
    expect(Accessory.find(@accessories[3].id).status).to eq('active')
    within("#accessory-#{@accessories[3].id}") do
      expect(page).to have_content('Active')
    end
  end
end
