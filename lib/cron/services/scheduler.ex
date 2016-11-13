defmodule Cron.Services.Scheduler do
  require Logger

  alias Quantum
  alias Cron.Services.Request

  def create(event) do
    job = %Quantum.Job{
      schedule: event.cron,
      task: fn -> Request.call(event.url) end
    }

    event.id
    |> encode_id
    |> Quantum.add_job(job)
  end

  def find(id) do
    id
    |> encode_id
    |> Quantum.find_job
  end

  def update(event) do
    delete(event.id)
    create(event)
  end

  def delete(id) do
    id
    |> encode_id
    |> Quantum.delete_job
  end

  defp encode_id(id) do
    str = "event_" <> Integer.to_string(id)
    String.to_atom("event_" <> str)
  end
end
