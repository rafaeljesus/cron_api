defmodule Cron.Router.Index do
  use Maru.Router

  import Ecto.Query

  alias Cron.{Repo, Event}

  version "v1"

  namespace :events do
    params do
      requires :url, type: String
      requires :cron, type: String
      optional :status, type: String
    end
    post do
      case Event.create(params) do
        {:ok, event} -> json conn, event
        {:error, _changeset} ->
          conn
          |> put_status(400)
          |> text("Insert Failed")
      end
    end
  end
end
