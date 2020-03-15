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
    pokemon = Pokemon.new(allowed_params)

    if pokemon.valid?
      pokemon.save
      
    else
      flash[:error] = pokemon.errors.full_messages
      render json: flash[:error]
    end

  end


  def destroy
    pokemon = Pokemon.find(params[:id])
    pokemon.destroy 
    
  end

  private 

  def allowed_params
    params.require(:pokemon).permit(:nickname, :species, :trainer_id)
  end
end
