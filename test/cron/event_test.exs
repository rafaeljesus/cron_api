defmodule Cron.EventTest do
  use ExUnit.Case
  alias Cron.{Repo, Event}
  import List

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
end
