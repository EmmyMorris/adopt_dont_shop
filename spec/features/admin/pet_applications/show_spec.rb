require 'rails_helper'

RSpec.describe 'the admin application show page' do
  before(:each) do
    @pet_application = PetApplication.create!(name: 'Kathy', street_address: '16998 Farmwell Drive', city: 'Denver', state: 'Colorado', zip_code: '80014', description: "I have no other pets", status: "Pending")
    @shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    @shelter_2 = Shelter.create(name: 'RGV animal shelter', city: 'Harlingen, TX', foster_program: false, rank: 5)
    @shelter_3 = Shelter.create(name: 'Fancy pets of Colorado', city: 'Denver, CO', foster_program: true, rank: 10)
    @pet_1 = @shelter_1.pets.create(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: true)
    @shelter_1.pets.create(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true)
    @pet_2 = @shelter_3.pets.create!(name: 'Lucille Bald', breed: 'sphynx', age: 8, adoptable: true)
    @pet_application.pets << @pet_1
    # @pet_1 = @pet_application.pets.create!(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: true)
  end
  it 'see a button to approve the application for that specific pet' do
    # Approving a Pet for Adoption
    # As a visitor
    # When I visit an admin application show page ('/admin/applications/:id')
    # For every pet that the application is for, I see a button to approve the application for that specific pet
    # When I click that button
    # Then I'm taken back to the admin application show page
    # And next to the pet that I approved, I do not see a button to approve this pet
    # And instead I see an indicator next to the pet that they have been approved
    new_application_id = PetApplication.last.id
    visit "/admin/pet_applications/#{@pet_application.id}"
    save_and_open_page
    click_on "Approve #{@pet_1.name}"
    expect(current_path).to eq("/admin/pet_applications/#{@pet_application.id}")
    expect(page).to_not have_content("Approve #{@pet_1.name}")
    expect(page).to have_content("Approved #{@pet_1.name}")
  end
end
