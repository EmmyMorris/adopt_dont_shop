require "rails_helper"

describe PetApplication, type: :model do
  describe "relationships" do
    it { should have_many :application_pets}
    it { should have_many(:pets).through(:application_pets) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:street_address) }
    it { should validate_presence_of(:city) }
    it { should validate_presence_of(:state) }
    it { should validate_numericality_of(:zip_code) }
  end

  before(:each) do
    @pet_application = PetApplication.create!(name: 'Kathy', street_address: '16998 Farmwell Drive', city: 'Denver', state: 'Colorado', zip_code: '80014', description: 'No kids', status: 'Pending')
    @shelter = Shelter.create(name: 'Mystery Building', city: 'Irvine CA', foster_program: false, rank: 9)
    @pet_1 = @pet_application.pets.create(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald', shelter_id: @shelter.id)
    @pet_2 = @pet_application.pets.create(adoptable: true, age: 3, breed: 'doberman', name: 'Lobster', shelter_id: @shelter.id)
  end


  describe 'class methods' do
    describe '#search' do
      it 'returns partial matches' do
        expect(Pet.search("ste")).to eq([@pet_2])
      end
    end
  end
end
