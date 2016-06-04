defmodule Cron.Scheduler do
  alias Quantum
  alias Cron.Request

  def add(event) do
    job = %Quantum.Job{
      schedule: event.cron,
      task: fn -> Request.call(event.url) end
    }
    job_id = encode_id(event.id)
    Quantum.add_job(job_id, job)
    {:ok, job_id}
  end

  def find(id) do
    job_id = encode_id(id)
    job = Quantum.find_job(job_id)
    {:ok, job}
  end

  def deactivate(id) do
    job_id = encode_id(id)
    job = Quantum.deactivate_job(job_id)
    {:ok, job}
  end

  def activate(id) do
    job_id = encode_id(id)
    job = Quantum.activate_job(job_id)
    {:ok, job}
  end

  def delete(id) do
    job_id = encode_id(id)
    job = Quantum.delete_job(job_id)
    {:ok, job}
  end

  defp encode_id(id), do: String.to_atom("event_" <> id)
end
