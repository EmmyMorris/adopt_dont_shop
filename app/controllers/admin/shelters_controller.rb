class Admin::SheltersController < ApplicationController
  def index
    @sorted_shelters = Shelter.sorted
  end
end
