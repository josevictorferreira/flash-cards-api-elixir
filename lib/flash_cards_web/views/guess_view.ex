defmodule FlashCardsWeb.GuessView do
  use FlashCardsWeb, :view
  alias FlashCardsWeb.GuessView

  def render("index.json", %{guesses: guesses}) do
    %{guesses: render_many(guesses, GuessView, "guess.json")}
  end

  def render("show.json", %{guess: guess}) do
    %{guess: render_one(guess, GuessView, "guess.json")}
  end

  def render("guess.json", %{guess: guess}) do
    %{
      id: guess.id,
      text: guess.text,
      correct: guess.correct,
      card_id: guess.card_id
    }
  end
end
