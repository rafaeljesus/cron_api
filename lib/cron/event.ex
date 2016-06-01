defmodule Cron.Event do
  use Ecto.Schema

  import Ecto.Query
  import Ecto.Changeset

  alias Cron.Repo

  @required_fields ~w(url cron)
  @optional_fields ~w(status)

  @primary_key {:id, :binary_id, autogenerate: true}
  @derive {Poison.Encoder, only: [:id, :url, :cron, :status]}
  schema "event" do
    field :url
    field :cron
    field :status
  end

  def create(params) do
    changeset(%__MODULE__{}, params)
    |> Repo.insert
  end

  def changeset(event, params \\ :empty) do
    event
    |> cast(params, @required_fields, @optional_fields)
  end
end
