defmodule FlashCards.Repo.Migrations.CreateGuesses do
  use Ecto.Migration

  def change do
    create table(:guesses) do
      add :text, :string
      add :correct, :boolean, default: false, null: false
      add :card_id, references(:cards, on_delete: :nothing)

      timestamps()
    end

    create index(:guesses, [:card_id])
  end
end
