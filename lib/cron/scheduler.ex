defmodule Cron.Scheduler do
  alias Quantum

  def add(event) do
    job = %Quantum.Job{
      schedule: event.cron,
      task: fn -> IO.puts "tick" end
    }
    job_id = encode_id(event.id)
    Quantum.add_job(job_id, job)
    {:ok, job_id}
  end

  def find(id) do
    job_id = encode_id(id)
    Quantum.find_job(job_id)
  end

  defp encode_id(id), do: String.to_atom("event_" <> Integer.to_string(id))
end
