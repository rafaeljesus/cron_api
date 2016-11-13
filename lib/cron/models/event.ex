defmodule Cron.Models.Event do
  use Ecto.Schema

  import Ecto.Changeset

  alias Cron.Repo
  alias Cron.Models.Event

  @required_fields ~w(url cron)
  @optional_fields ~w(status)

  @derive {Poison.Encoder, except: [:__meta__, :__struct__]}
  schema "events" do
    field :url, :string
    field :cron, :string
    field :status, :string, default: "active"

    timestamps
  end

  def changeset(event, params \\ %{}) do
    event
    |> cast(params, @required_fields, @optional_fields)
    |> validate_required([:url, :cron])
  end

  def search(params \\ %{status: "active"}) do
    status = params[:status]
    Event
    |> where([c], c.status == ^status)
    |> Repo.paginate(params)
  end
end
