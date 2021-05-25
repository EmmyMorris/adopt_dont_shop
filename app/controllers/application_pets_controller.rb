class ApplicationPetsController < ApplicationController
  def create
    pet = Pet.find(params[:pet])
    application = PetApplication.find(params[:app])
    ApplicationPet.create!(pet: pet, pet_application: application)
    redirect_to "/pet_applications/#{application.id}"
  end
end
