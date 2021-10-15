defmodule FlashCards.Cards.Card do
  @moduledoc false
  use Ecto.Schema
  import Ecto.Changeset

  schema "cards" do
    field :answer, :string
    field :discarded, :boolean, default: false
    field :text, :string
    field :user_id, :integer

    timestamps()
  end

  @doc false
  def changeset(card, attrs) do
    card
    |> cast(attrs, [:text, :answer, :discarded, :user_id])
    |> validate_required([:text, :answer, :discarded, :user_id])
  end
end
