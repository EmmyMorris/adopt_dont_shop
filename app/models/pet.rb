class Pet < ApplicationRecord
  validates :name, presence: true
  validates :age, presence: true, numericality: true

  belongs_to :shelter
  has_many :application_pets
  has_many :pet_applications, through: :application_pets

  def shelter_name
    shelter.name
  end

  def self.adoptable
    where(adoptable: true)
  end

  def status(pet_application)
    ApplicationPet.find_by(:pet_application_id => pet_application.id, :pet_id => id)
  end
end
