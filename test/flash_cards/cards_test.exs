defmodule FlashCards.CardsTest do
  use FlashCards.DataCase

  alias FlashCards.Cards

  describe "cards" do
    alias FlashCards.Cards.Card

    import FlashCards.CardsFixtures

    @invalid_attrs %{answer: nil, discarded: nil, text: nil, user_id: nil}

    test "list_cards/0 returns all cards" do
      card = card_fixture()
      assert Cards.list_cards() == [card]
    end

    test "get_card!/1 returns the card with given id" do
      card = card_fixture()
      assert Cards.get_card!(card.id) == card
    end

    test "create_card/1 with valid data creates a card" do
      valid_attrs = %{answer: "some answer", discarded: true, text: "some text", user_id: 42}

      assert {:ok, %Card{} = card} = Cards.create_card(valid_attrs)
      assert card.answer == "some answer"
      assert card.discarded == true
      assert card.text == "some text"
      assert card.user_id == 42
    end

    test "create_card/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Cards.create_card(@invalid_attrs)
    end

    test "update_card/2 with valid data updates the card" do
      card = card_fixture()
      update_attrs = %{answer: "some updated answer", discarded: false, text: "some updated text", user_id: 43}

      assert {:ok, %Card{} = card} = Cards.update_card(card, update_attrs)
      assert card.answer == "some updated answer"
      assert card.discarded == false
      assert card.text == "some updated text"
      assert card.user_id == 43
    end

    test "update_card/2 with invalid data returns error changeset" do
      card = card_fixture()
      assert {:error, %Ecto.Changeset{}} = Cards.update_card(card, @invalid_attrs)
      assert card == Cards.get_card!(card.id)
    end

    test "delete_card/1 deletes the card" do
      card = card_fixture()
      assert {:ok, %Card{}} = Cards.delete_card(card)
      assert_raise Ecto.NoResultsError, fn -> Cards.get_card!(card.id) end
    end

    test "change_card/1 returns a card changeset" do
      card = card_fixture()
      assert %Ecto.Changeset{} = Cards.change_card(card)
    end
  end

  describe "guesses" do
    alias FlashCards.Cards.Guess

    import FlashCards.CardsFixtures

    @invalid_attrs %{correct: nil, text: nil}

    test "list_guesses/0 returns all guesses" do
      guess = guess_fixture()
      assert Cards.list_guesses() == [guess]
    end

    test "get_guess!/1 returns the guess with given id" do
      guess = guess_fixture()
      assert Cards.get_guess!(guess.id) == guess
    end

    test "create_guess/1 with valid data creates a guess" do
      valid_attrs = %{correct: true, text: "some text"}

      assert {:ok, %Guess{} = guess} = Cards.create_guess(valid_attrs)
      assert guess.correct == true
      assert guess.text == "some text"
    end

    test "create_guess/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Cards.create_guess(@invalid_attrs)
    end

    test "update_guess/2 with valid data updates the guess" do
      guess = guess_fixture()
      update_attrs = %{correct: false, text: "some updated text"}

      assert {:ok, %Guess{} = guess} = Cards.update_guess(guess, update_attrs)
      assert guess.correct == false
      assert guess.text == "some updated text"
    end

    test "update_guess/2 with invalid data returns error changeset" do
      guess = guess_fixture()
      assert {:error, %Ecto.Changeset{}} = Cards.update_guess(guess, @invalid_attrs)
      assert guess == Cards.get_guess!(guess.id)
    end

    test "delete_guess/1 deletes the guess" do
      guess = guess_fixture()
      assert {:ok, %Guess{}} = Cards.delete_guess(guess)
      assert_raise Ecto.NoResultsError, fn -> Cards.get_guess!(guess.id) end
    end

    test "change_guess/1 returns a guess changeset" do
      guess = guess_fixture()
      assert %Ecto.Changeset{} = Cards.change_guess(guess)
    end
  end
end
