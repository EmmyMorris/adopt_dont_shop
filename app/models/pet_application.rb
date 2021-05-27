class PetApplication < ApplicationRecord
  validates :name, presence: true
  validates :street_address, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :zip_code, presence: true, numericality: true
  # validates :description, presence: true
  # validates :status, presence: true

  has_many :application_pets, dependent: :destroy
  has_many :pets, through: :application_pets
end
