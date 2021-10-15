defmodule FlashCardsWeb.CardView do
  use FlashCardsWeb, :view
  alias FlashCardsWeb.CardView

  def render("index.json", %{cards: cards}) do
    %{data: render_many(cards, CardView, "card.json")}
  end

  def render("show.json", %{card: card}) do
    %{data: render_one(card, CardView, "card.json")}
  end

  def render("card.json", %{card: card}) do
    %{
      id: card.id,
      text: card.text,
      answer: card.answer,
      discarded: card.discarded,
      user_id: card.user_id
    }
  end
end
