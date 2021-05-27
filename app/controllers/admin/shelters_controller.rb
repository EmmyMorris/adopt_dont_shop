class Admin::SheltersController < ApplicationController
  def index
    @sorted_shelters = Shelter.sorted
    @pending_shelters =  Shelter.pending_shelters
  end
end
