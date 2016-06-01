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
          |> put_status(422)
          |> text("Uprocessable Entity")
      end
    end

    route_param :id do
      get do
        event = Event.get(params[:id])
        json conn, event
      end

      params do
        optional :url, type: String
        optional :cron, type: String
        optional :status, type: String
        at_least_one_of [:url, :cron, :status]
      end
      patch do
        with {:ok, event} <- Event.get(params[:task_id]),
          {:ok, event} <- Event.update(event, params),
          do: json conn, event
      end
    end
  end
end
