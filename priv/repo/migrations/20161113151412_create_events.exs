defmodule Cron.Repo.Migrations.CreateEvents do
  use Ecto.Migration

  def change do
    create table(:events) do
      add :url, :string, null: false
      add :cron, :string, null: false
      add :status, :string

      timestamps
    end

    create index(:events, [:url])
    create index(:events, [:cron])
    create index(:events, [:status])
  end
end
