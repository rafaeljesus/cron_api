defmodule Cron.Models.EventTest do
  use ExUnit.Case

  alias Cron.Models.Event

  @invalid_attrs %{}
  @valid_attrs %{
    url: "https://api.github.com/users/rafaeljesus/events",
    cron: "* * * * *",
    status: "active"
  }

  test "changeset with valid attributes" do
    changeset = Event.changeset(%Event{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Event.changeset(%Event{}, @invalid_attrs)
    refute changeset.valid?
  end
end
