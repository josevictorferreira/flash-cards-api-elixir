defmodule FlashCardsWeb.CardControllerTest do
  use FlashCardsWeb.ConnCase

  import FlashCards.CardsFixtures

  alias FlashCards.Cards.Card

  @create_attrs %{
    answer: "some answer",
    discarded: true,
    text: "some text",
    user_id: 42
  }
  @update_attrs %{
    answer: "some updated answer",
    discarded: false,
    text: "some updated text",
    user_id: 43
  }
  @invalid_attrs %{answer: nil, discarded: nil, text: nil, user_id: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all cards", %{conn: conn} do
      conn = get(conn, Routes.card_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create card" do
    test "renders card when data is valid", %{conn: conn} do
      conn = post(conn, Routes.card_path(conn, :create), card: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.card_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "answer" => "some answer",
               "discarded" => true,
               "text" => "some text",
               "user_id" => 42
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.card_path(conn, :create), card: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update card" do
    setup [:create_card]

    test "renders card when data is valid", %{conn: conn, card: %Card{id: id} = card} do
      conn = put(conn, Routes.card_path(conn, :update, card), card: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.card_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "answer" => "some updated answer",
               "discarded" => false,
               "text" => "some updated text",
               "user_id" => 43
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, card: card} do
      conn = put(conn, Routes.card_path(conn, :update, card), card: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete card" do
    setup [:create_card]

    test "deletes chosen card", %{conn: conn, card: card} do
      conn = delete(conn, Routes.card_path(conn, :delete, card))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.card_path(conn, :show, card))
      end
    end
  end

  defp create_card(_) do
    card = card_fixture()
    %{card: card}
  end
end
