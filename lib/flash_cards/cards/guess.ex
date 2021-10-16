defmodule FlashCards.Cards.Guess do
  @moduledoc false
  use Ecto.Schema
  import Ecto.Changeset

  schema "guesses" do
    field :correct, :boolean, default: false
    field :text, :string
    belongs_to :card, FlashCards.Cards.Card, foreign_key: :card_id

    timestamps()
  end

  @doc false
  def changeset(guess, attrs) do
    guess
    |> cast(attrs, [:text, :correct, :card_id])
    |> validate_required([:text, :correct, :card_id])
  end
end
