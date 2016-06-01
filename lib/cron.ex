defmodule Cron do
  use Application

  def start(_type, _args) do
    Cron.Supervisor.start_link
  end
end
