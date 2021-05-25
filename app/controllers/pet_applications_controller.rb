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
    pet_application = PetApplication.new(
      name: params[:name],
      street_address: params[:street_address],
      city: params[:city],
      state: params[:state],
      zip_code: params[:zip_code],
      description: '',
      status: "In Progress"
      )
    if pet_application.save
      redirect_to "/pet_applications/#{pet_application.id}"
    else
      flash[:alert] = "Application not created: Required information missing."
      render :new
    end
  end

  # def update
  #   @pet_application = PetApplication.find(params[:id])
  #   @pet = Pet.find(params[:pet_id])
  #   @pet_application.pets << @pet
  # end

  private

  def pet_application_params
    params.permit(:id, :name, :street_address, :city, :state, :zip_code, :description, :status)
  end
end
