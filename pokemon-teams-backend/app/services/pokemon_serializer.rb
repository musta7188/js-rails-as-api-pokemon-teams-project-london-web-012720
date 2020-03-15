class PokemonSerializer


  def initialize(pokemon)
    @pokemon = pokemon
  end

  def to_serialized_json
     options = {
      include: {
        trainer: {
          only: [:name, :id]
        	},
      },
      only: [:nickname, :species, :id],
    }

    @pokemon.to_json(options)
  end
end
