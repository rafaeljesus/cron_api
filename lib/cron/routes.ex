defmodule Cron.Router.Index do
  use Maru.Router
  alias Cron.{Repo, Search, Event}, warn: false

  version "v1"

  namespace :events do
    get do
      cron = fetch_query_params(conn)
      events = Search.new(cron.params)
      json conn, events
    end

    params do
      requires :url, type: String
      requires :cron, type: String
      optional :status, type: String
    end
    post do
      changeset = Event.changeset(%Event{}, params)
      case Repo.insert(changeset) do
        {:ok, event} -> json conn, event
        {:error, _changeset} ->
          conn
          |> put_status(422)
          |> text("Uprocessable Entity")
      end
    end

    route_param :id do
      get do
        event = Repo.get!(Event, params[:id])
        json conn, event
      end

      params do
        optional :url, type: String
        optional :cron, type: String
        optional :status, type: String
        at_least_one_of [:url, :cron, :status]
      end
      patch do
        event = Event |> Repo.get(params[:id])
        changeset = Event.changeset(event, params)
        case Repo.update(changeset) do
        {:ok, event} -> json conn, event
        {:error, _changeset} ->
          conn
          |> put_status(422)
          |> text("Uprocessable Entity")
        end
      end

      delete do
        event = Event |> Repo.get(params[:id])
        case Repo.delete(event) do
          {:ok, event} -> json conn, event
          _ ->
            conn
            |> put_status(412)
            |> text("Precondition Failed")
        end
      end
    end
  end
end
