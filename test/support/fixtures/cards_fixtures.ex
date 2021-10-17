defmodule FlashCards.CardsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `FlashCards.Cards` context.
  """

  @doc """
  Generate a card.
  """
  def card_fixture(attrs \\ %{}) do
    {:ok, card} =
      attrs
      |> Enum.into(%{
        answer: "some answer",
        discarded: true,
        text: "some text",
        user_id: 42
      })
      |> FlashCards.Cards.create_card()

    card
  end

  @doc """
  Generate a guess.
  """
  def guess_fixture(attrs \\ %{}) do
    {:ok, guess} =
      attrs
      |> Enum.into(%{
        correct: true,
        text: "some text",
        card_id: card_fixture().id
      })
      |> FlashCards.Cards.create_guess()

    guess
  end
end
