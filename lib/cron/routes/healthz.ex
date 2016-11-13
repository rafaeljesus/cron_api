defmodule Cron.Routes.Healthz do
  use Maru.Router

  version "v1"

  namespace :healthz do
    get do
      json(conn, %{alive: true})
    end
  end
end
