defmodule FlashCards.Repo do
  use Ecto.Repo,
    otp_app: :flash_cards,
    adapter: Ecto.Adapters.Postgres
end
