class Admin::PetApplicationsController < ApplicationController
  def show
    @pet_application = PetApplication.find(params[:id])
    @pets = @pet_application.pets
  end

  def approved
    binding.pry
    pet_application = PetApplication.find(params[:id])
    binding.pry
    pet = Pet.find(params[:pet_id])
    @approve_pet = ApplicationPet.where(:pet_application_id => pet_application.id, :pet_id => pet.id)[0]
    @approve_pet.status = "Approved"
    @approve_pet.save
    redirect_to "/admin/pet_applications/#{pet_application.id}"
  end
end
