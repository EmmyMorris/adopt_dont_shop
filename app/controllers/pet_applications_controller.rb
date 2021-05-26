class PetApplicationsController < ApplicationController
  def show
    @pet_application = PetApplication.find(params[:id])
    @pets = @pet_application.pets
    @all_pets = Pet.all
    if params[:search].present?
      @adoptable_pets = Pet.search(params[:search])
    else
      @adoptable_pets = []
    end
  end

  def new
  end

  def create
    pet_application = PetApplication.new(pet_application_params)
    pet_application.description = '' || nil
    pet_application.status = "In Progress"
    if pet_application.save
      redirect_to "/pet_applications/#{pet_application.id}"
    else
      flash[:alert] = "Application not created: Required information missing."
      render :new
    end
  end

  def update
    @pet_application = PetApplication.find(params[:id])
    if params[:description]
      @pet_application.description = params[:description]
      @pet_application.status = "Pending"
      @pet_application.save!
      redirect_to "/pet_applications/#{@pet_application.id}"
    end
  end

  private

  def pet_application_params
    params.permit(:name, :street_address, :city, :state, :zip_code)
  end
end
