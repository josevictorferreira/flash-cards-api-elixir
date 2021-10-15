defmodule FlashCards.Repo.Migrations.CreateCards do
  use Ecto.Migration

  def change do
    create table(:cards) do
      add :text, :string
      add :answer, :string
      add :discarded, :boolean, default: false, null: false
      add :user_id, :bigint

      timestamps()
    end

    create index("cards", [:user_id])
  end
end
