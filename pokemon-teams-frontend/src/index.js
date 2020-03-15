const BASE_URL = "http://localhost:3000"
const TRAINERS_URL = `${BASE_URL}/trainers`
const POKEMONS_URL = `${BASE_URL}/pokemons`


document.addEventListener("DOMContentLoaded", () => {

    fetch(TRAINERS_URL)
        .then(response => response.json())
        .then(json => json.forEach(trainer => { showAll(trainer, trainer.pokemons) }))

})

function showAll(trainer, pokemons) {

    const main = document.querySelector("main")
    const newDiv = document.createElement("div")

    newDiv.setAttribute("class", "card")
    newDiv.setAttribute("data-id", trainer.id)

    const p = document.createElement("p")
    p.innerText = trainer.name

    const btn = document.createElement("button")
    btn.setAttribute("data-trainer-id", trainer.id)
    btn.innerText = "Add Pokemon"
    btn.addEventListener("click", event => {
        event.preventDefault()
        if (pokemons.length < 7) {
            newPokemon(trainer);
            // location.reload();
        } else {
            alert("Your Team is complete")
                // location.reload();
        }

    })

    const ul = document.createElement("ul")

    pokemons.forEach(pokemon => {
        const li = document.createElement("li")
        li.innerText = `${pokemon.nickname}, (${pokemon.species})  `

        const buttonR = document.createElement("button")
        buttonR.setAttribute("class", "release")
        buttonR.setAttribute("data-pokemon-id", pokemon.id)
        buttonR.innerText = "release"
        buttonR.addEventListener("click", event => {
            removePokemon(pokemon.id)
            li.remove()
            buttonR.remove()
        })

        li.append(buttonR)
        ul.append(li)
        newDiv.append(p, btn, ul)
        main.append(newDiv)

    })

}


function newPokemon(trainer) {
    const confObj = {
        method: "POST",
        headers: {
            "Content-Type": "application/json",
            "Accept": "application/json"
        },
        body: JSON.stringify({
            nickname: "TestName",
            species: "TestSpecies",
            trainer_id: trainer.id
        })
    }

    fetch("http://localhost:3000/pokemons", confObj)
        .then(response => response.json())
        .then(obj => console.log(obj))
        .catch(error => console.log(error))
}


function removePokemon(pId) {
    const confObj = {
        method: "DELETE",
        headers: {
            "Content-Type": "application/json",
            "Accept": "application/json"
        }
    }

    fetch(`http://localhost:3000/pokemons/${pId}`, confObj)
        .then(res => res.json())
        .then(res => console.log(res))

}