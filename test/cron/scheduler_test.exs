defmodule Cron.SearchTest do
  use ExUnit.Case
  alias Cron.{Scheduler, Event}

  test "should add job" do
    with event <- %Event{id: 1, cron: '* * * * *'},
      {:ok, job_id} <- Scheduler.add(event),
      {:ok, job} <- Scheduler.find(event.id),
      do: assert job.state == 'active'
  end
end
