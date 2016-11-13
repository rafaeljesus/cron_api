defmodule Cron.Routes.Event do
  use Maru.Router

  alias Cron.Repo
  alias Cron.Models.Event
  alias Cron.Services.Scheduler

  version "v1"

  namespace :events do
    get do
      result = conn
      |> fetch_query_params
      |> Map.get(:params)
      |> Event.search

      json(conn, result)
    end

    params do
      requires :url, type: String
      requires :cron, type: String
      optional :status, type: String
    end
    post do
      %Event{}
      |> Event.changeset(params)
      |> Repo.insert
      |> Scheduler.create

      conn
      |> put_status(:created)
      |> put_resp_content_type("application/json")
    end

    route_param :id do
      get do
        event = Repo.get!(Event, params[:id])
        json(conn, event)
      end

      params do
        optional :url, type: String
        optional :cron, type: String
        optional :status, type: String
        at_least_one_of [:url, :cron, :status]
      end
      patch do
        event = Event
        |> Repo.get(params[:id])
        |> Event.changeset(params)
        |> Repo.update
        |> Scheduler.update

        json(conn, event)
      end

      delete do
        Event
        |> Repo.get(params[:id])
        |> Repo.delete
        |> Scheduler.delete

        conn
        |> put_status(204)
        |> put_resp_content_type("application/json")
      end
    end
  end
end
