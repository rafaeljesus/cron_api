defmodule Cron.API do
  use Maru.Router

  plug CORSPlug
  plug Plug.Logger
  plug Plug.Parsers,
    pass: ["*/*"],
    parsers: [:json],
    json_decoder: Poison

  mount Cron.Routes.Healthz
  mount Cron.Routes.Event

  rescue_from :all, as: e do
    IO.inspect(e)
    conn
    |> put_status(500)
    |> json(%{message: "Server Error"})
  end
end
