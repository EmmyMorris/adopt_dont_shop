require 'rails_helper'

RSpec.describe 'the application creation' do
  before(:each) do
    @pet_application = PetApplication.create!(name: 'Kathy', street_address: '16998 Farmwell Drive', city: 'Denver', state: 'Colorado', zip_code: '80014', description: 'No kids', status: 'Pending')
    @shelter = Shelter.create(name: 'Mystery Building', city: 'Irvine CA', foster_program: false, rank: 9)
    @pet_1 = Pet.create!(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald', shelter_id: @shelter.id)
    @pet_2 = Pet.create!(adoptable: true, age: 3, breed: 'doberman', name: 'Lobster', shelter_id: @shelter.id)
    @pet_3 = Pet.create!(adoptable: true, age: 4, breed: 'chihuahua', name: 'Barkey', shelter_id: @shelter.id)
  end

  it "shows the pet application and all it's attributes" do
    # Application Show Page
    #
    # As a visitor
    # When I visit an applications show page
    # Then I can see the following:
    # - Name of the Applicant
    # - Full Address of the Applicant including street address, city, state, and zip code
    # - Description of why the applicant says they'd be a good home for this pet(s)
    # - names of all pets that this application is for (all names of pets should be links to their show page)
    # - The Application's status, either "In Progress", "Pending", "Accepted", or "Rejected"
    # shelter = Shelter.create(name: 'Mystery Building', city: 'Irvine CA', foster_program: false, rank: 9)
    # pet = PetApplication.pet.create!(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald', shelter_id: @shelter.id)
    pet = @pet_application.pets.create!(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald', shelter_id: @shelter.id)
    visit "/pet_applications/#{@pet_application.id}"
    expect(page).to have_content(@pet_application.name)
    expect(page).to have_content(@pet_application.street_address)
    expect(page).to have_content(@pet_application.city)
    expect(page).to have_content(@pet_application.state)
    expect(page).to have_content(@pet_application.zip_code)
    expect(page).to have_content(@pet_application.description)
    expect(page).to have_content(@pet_application.status)
    expect(page).to have_content(pet.name)
  end

  it "Searches for Pets for an Application" do
    # Searching for Pets for an Application
    # As a visitor
    # When I visit an application's show page
    # And that application has not been submitted,
    # Then I see a section on the page to "Add a Pet to this Application"
    # In that section I see an input where I can search for Pets by name
    # When I fill in this field with a Pet's name
    # And I click submit,
    # Then I am taken back to the application show page
    # And under the search bar I see any Pet whose name matches my search
    visit "/pet_applications/#{@pet_application.id}"
    fill_in 'Search', with: "Ba"
    click_on("Search")

    expect(page).to have_content(@pet_1.name)
    expect(page).to have_content(@pet_3.name)
    expect(page).to_not have_content(@pet_2.name)
  end

  it 'adds a pet to an application' do
    # Add a Pet to an Application
    #
    # As a visitor
    # When I visit an application's show page
    # And I search for a Pet by name
    # And I see the names Pets that match my search
    # Then next to each Pet's name I see a button to "Adopt this Pet"
    # When I click one of these buttons
    # Then I am taken back to the application show page
    # And I see the Pet I want to adopt listed on this application
    visit "/pet_applications/#{@pet_application.id}"
    fill_in 'Search', with: "Lucille Bald"
    click_on("Search")
    expect(page).to have_content(@pet_1.name)
    click_on("Adopt #{@pet_1.name}")
    expect(current_path).to eq("/pet_applications/#{@pet_application.id}")
    expect(page).to have_content(@pet_1.name)
  end
end
