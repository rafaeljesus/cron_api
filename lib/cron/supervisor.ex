defmodule Cron.Supervisor do
  use Supervisor

  @name __MODULE__

  def init([]) do
    [worker(Cron.Repo, [])]
    |> supervise(strategy: :one_for_one)
  end

  def start_link do
    Supervisor.start_link(@name, [], name: @name)
  end
end

