# loš način
# Problemi:
# 1. custom find koji pripada u Toy model
# 2. ne koriste se opcije za Active Recorda
class PetsController < ApplicationController
  def show
    @pet = Pet.find(params[:id])
    @toy = Toy.where(pet_id: @pet.id, cute: true)
  end
end

# Active Record asocijacije i Finders
class PetsController < ApplicationController
  def show
    @pet = Pet.find(params[:id])
    @toys = @pet.toys.cute
  end
end

class Toy < ActiveRecord::Base
  def self.cute
    where(cute: true)
  end
end

# toys je associatoin proxy koji omogućava da se poziva bilo koja class metoda
# na Toy objektu
class Pet < ActiveRecord::Base
  has_many :toys
end
