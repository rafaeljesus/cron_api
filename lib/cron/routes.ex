defmodule Cron.Router.Index do
  use Maru.Router
  alias Quantum, warn: false
  alias Cron.{Repo, Search, Event, Scheduler}, warn: false

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
      result = with changeset <- Event.changeset(%Event{}, params),
        {:ok, event} <- Repo.insert(changeset),
        do: {:ok, event}

      wrap conn, result
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
        result = with event <- Event |> Repo.get(params[:id]),
          changeset <- Event.changeset(event, params),
          {:ok, event} <- Repo.update(changeset),
          do: {:ok, event}

        wrap conn, result
      end

      delete do
        result = with event <- Event |> Repo.get(params[:id]),
          {:ok, event} <- Repo.delete(event),
          do: {:ok, event}

        wrap conn, result
      end

      defp wrap(conn, result) do
        case result do
          {:ok, event} -> json conn, event
          {:error, _changeset} -> boom conn, _changeset
        end
      end

      defp boom(conn, _changeset) do
        conn
        |> put_status(422)
        |> text("Uprocessable Entity")
      end
    end
  end
end
