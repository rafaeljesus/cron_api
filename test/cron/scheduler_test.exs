defmodule Cron.Services.SchedulerTest do
  use ExUnit.Case

  alias Cron.Models.Event
  alias Cron.Services.Scheduler

  @id 1
  @cron "* * * * *"

  setup do
    on_exit fn -> Scheduler.delete(@id) end
    event = %Event{id: @id, cron: @cron}
    {:ok, %{event: event}}
  end

  test "creates an job", %{event: event} do
    job_id = Scheduler.create(event)
    assert job_id != nil
  end

  test "finds an job", %{event: event} do
    Scheduler.create(event)
    job = Scheduler.find(event.id)
    assert job.state == :active
  end

  test "deletes an job", %{event: event} do
    Scheduler.delete(event.id)
    job = Scheduler.find(event.id)
    assert job == nil
  end
end
