require 'rails_helper'

RSpec.describe 'the admin shelter index' do
  before(:each) do
    @pet_application = PetApplication.create!(name: 'Kathy', street_address: '16998 Farmwell Drive', city: 'Denver', state: 'Colorado', zip_code: '80014', description: "I have no other pets", status: "Pending")
    @pet_application_2 = PetApplication.create!(name: 'Margert', street_address: '16998 Drawer Drive', city: 'Denver', state: 'Colorado', zip_code: '12345', description: "I have no other pets", status: "In Progress")

    @shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    @shelter_2 = Shelter.create(name: 'RGV animal shelter', city: 'Harlingen, TX', foster_program: false, rank: 5)
    @shelter_3 = Shelter.create(name: 'Fancy pets of Colorado', city: 'Denver, CO', foster_program: true, rank: 10)
    @pet_1 = @shelter_1.pets.create(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: true)
    @shelter_1.pets.create(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true)
    @pet_2 = @shelter_3.pets.create!(name: 'Lucille Bald', breed: 'sphynx', age: 8, adoptable: true)
  end
  it 'lists shelter by reverse alphabetical order' do
    # SQL Only Story
    # For this story, you should write your queries in raw sql. You can use the ActiveRecord find_by_sql method to execute raw sql queries: https://guides.rubyonrails.org/active_record_querying.html#finding-by-sql
    # Admin Shelters Index
    # As a visitor
    # When I visit the admin shelter index ('/admin/shelters')
    # Then I see all Shelters in the system listed in reverse alphabetical order by name

    visit "/admin/shelters"
    expect(page).to have_content(@shelter_1.name)
    expect(page).to have_content(@shelter_2.name)
    expect(page).to have_content(@shelter_3.name)
    expect(@shelter_2.name).to appear_before(@shelter_3.name)
    expect(@shelter_3.name).to appear_before(@shelter_1.name)
  end

  it "shows shelters with pending invoices" do
    # For this story, you should fully leverage ActiveRecord methods in your query.
    # Shelters with Pending Applications
    # As a visitor
    # When I visit the admin shelter index ('/admin/shelters')
    # Then I see a section for "Shelter's with Pending Applications"
    # And in this section I see the name of every shelter that has a pending application
    ApplicationPet.create!(pet: @pet_1, pet_application: @pet_application)
    ApplicationPet.create!(pet: @pet_2, pet_application: @pet_application_2)
    # pet_1 = Shelter.pets
    visit "/admin/shelters"
    within("div#pending") do

      expect(page).to have_content("Shelter's with Pending Applications")
      expect(page).to have_content(@shelter_1.name)
      expect(page).to_not have_content(@shelter_2.name)
    end
  end
end
