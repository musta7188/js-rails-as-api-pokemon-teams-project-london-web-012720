class TrainerSerializer


  def initialize(trainer)
    @trainer = trainer
  end

  def to_serialized_json
     options = {
      include: {
        pokemons: {
          only: [:nickname, :species, :id]
        	},
      },
      only: [:name, :id],
    }

    @trainer.to_json(options)
  end
end






