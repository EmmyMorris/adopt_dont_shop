class Admin::PetApplicationsController < ApplicationController
  def show
    @pet_application = PetApplication.find(params[:id])
    @pets = @pet_application.pets
  end

  def update
    pet_application = PetApplication.find(params[:id])
    @pet = Pet.search(params[:pet_id])
    @approved_pet = ApplicationPet.where(:pet_application_id => pet_application.id, :pet_id => @pet.id)[0]
    @approved_pet.status = "Approved"
    @approved_pet.save

    redirect_to "/admin/pet_applications/#{@pet_application}"
  end
end
