defmodule Cron.EventTest do
  use ExUnit.Case
  alias Cron.{Repo, Event}

  @body %{
    url: "https://api.github.com/users/rafaeljesus/events",
    cron: "* * * * *",
    status: "active"
  }

  setup do
    on_exit fn ->
      Repo.delete_all(Event)
    end
  end

  test "should create event job" do
    case Event.create(@body) do
      {:ok, model} -> assert model.cron == @body[:cron]
    end
  end

  test "should update event job" do
    inactive = 'inactive'
    with {:ok, model} <- Event.create(@body),
      {:ok, model} <- Event.update(model, Map.merge(@body, %{status: inactive})),
      do: assert inactive == model.status
  end
end
