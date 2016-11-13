defmodule Cron do
  use Application

  import Supervisor.Spec

  def start(_type, _args),
    do: Supervisor.start_link(children, opts)

  defp opts, do: [strategy: :one_for_one, name: Cron]

  defp children do
    [supervisor(Cron.Repo, [])]
  end
end
