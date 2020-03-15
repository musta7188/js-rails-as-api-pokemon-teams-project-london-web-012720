class Trainer < ApplicationRecord
  has_many :pokemons
  validate :pokemon_size
  accepts_nested_attributes_for :pokemons



  def pokemon_size 
    if self.pokemons.length > 6 
      errors.add(:team_limit, "your pokemon team is full")
    end
  end
end
