defmodule FlashCardsWeb.GuessController do
  use FlashCardsWeb, :controller

  alias FlashCards.Cards
  alias FlashCards.Cards.Guess

  action_fallback FlashCardsWeb.FallbackController

  def index(conn, _params) do
    guesses = Cards.list_guesses()
    render(conn, "index.json", guesses: guesses)
  end

  def create(conn, %{"card_id" => card_id, "guess" => guess_params}) do
    {card_id_number, _} = Integer.parse(card_id)
    guess_data = Map.merge(%{"card_id" => card_id_number}, guess_params)
    with {:ok, %Guess{} = guess} <- Cards.create_guess(guess_data) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.card_guess_path(conn, :show, card_id, guess))
      |> render("show.json", guess: guess)
    end
  end

  def show(conn, %{"id" => id}) do
    guess = Cards.get_guess!(id)
    render(conn, "show.json", guess: guess)
  end

  def update(conn, %{"id" => id, "guess" => guess_params}) do
    guess = Cards.get_guess!(id)

    with {:ok, %Guess{} = guess} <- Cards.update_guess(guess, guess_params) do
      render(conn, "show.json", guess: guess)
    end
  end

  def delete(conn, %{"id" => id}) do
    guess = Cards.get_guess!(id)

    with {:ok, %Guess{}} <- Cards.delete_guess(guess) do
      send_resp(conn, :no_content, "")
    end
  end
end
