class PokemonsController < ApplicationController

  def index 
    pokemons = Pokemon.all 
    render json: PokemonSerializer.new(pokemons).to_serialized_json
  end

  def show 
    pokemon = Pokemon.find(params[:id])
    render json: PokemonSerializer.new(pokemon).to_serialized_json
  end

  def create
    # we can createa a validator here by looking for the trainer params[pokemon][trainer_id] and check the size of its team
    pokemon = Pokemon.new(nickname: Faker::Name.first_name, species: Faker::Games::Pokemon.name, trainer_id: params[:trainer_id])
    
    if pokemon.valid? && pokemon.trainer.valid?
      pokemon.save
      render json: pokemon, status: 200
    else
      flash[:error] = pokemon.errors.full_messages
      render json: flash[:error], status: 404
    end

  end


  def destroy
    pokemon = Pokemon.find(params[:id])
    unless pokemon.nil?
      pokemon.destroy
      render json: pokemon
    else
      render json: { error: "Pokemon not Found!" }, status: 404
    end
    
  end


end
