require 'rails_helper'

RSpec.describe 'the application index' do
  before(:each) do
    @pet_application = PetApplication.create!(name: 'Kathy', street_address: '16998 Farmwell Drive', city: 'Denver', state: 'Colorado', zip_code: '80014', description: 'No kids', status: 'Pending')
  end

  it 'show a link to start an application' do
    # Starting an Application
    #
    # As a visitor
    # When I visit the pet index page
    # Then I see a link to "Start an Application"
    # When I click this link
    # Then I am taken to the new application page where I see a form
    # When I fill in this form with my:
    #   - Name
    #   - Street Address
    #   - City
    #   - State
    #   - Zip Code
    # And I click submit
    # Then I am taken to the new application's show page
    # And I see my Name, address information, and description of why I would make a good home
    # And I see an indicator that this application is "In Progress"
    visit "/pets"
    click_link("Start an Application")
    expect(current_path).to eq("/pet_applications/new/")
    fill_in 'Name', with: "Kathy"
    fill_in 'Street address', with: "16998 Farmwell Drive"
    fill_in 'City', with: "Denver"
    fill_in 'State', with: "Colorado"
    fill_in 'Zip code', with: "80014"
    click_on("Save")
    new_application_id = PetApplication.last.id
    expect(current_path).to eq("/pet_applications/#{new_application_id}")
  end

  it "redirects to same page if form is not filled out all the way" do
    # Starting an Application, Form not Completed
    # As a visitor
    # When I visit the new application page
    # And I fail to fill in any of the form fields
    # And I click submit
    # Then I am taken back to the new applications page
    # And I see a message that I must fill in those fields.
    visit "/pets"
    click_link("Start an Application")
    expect(current_path).to eq("/pet_applications/new/")
    fill_in 'Name', with: "Kathy"
    fill_in 'Street address', with: "16998 Farmwell Drive"
    #doesn't fill in city
    fill_in 'State', with: "Colorado"
    fill_in 'Zip code', with: "80014"
    click_on("Save")
    expect(page).to have_content("Application not created: Required information missing.")
    expect(current_path).to eq("/pet_applications/new")
  end
end
