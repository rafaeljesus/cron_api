defmodule Cron.Routes.EventTest do
  use ExUnit.Case
  use Maru.Test, for: Cron.API

  alias Cron.Repo
  alias Cron.Models.Event

  @valid_attrs %{
    url: "https://api.github.com/users/rafaeljesus/events",
    cron: "* * * * *",
    status: "active"
  }

  setup do
    model = %Event{}
    |> Event.changeset(@valid_attrs)
    |> Repo.insert!

    on_exit fn ->
      Repo.delete_all(Event)
    end

    {:ok, %{model: model}}
  end

  test "POST /v1/events" do
    conn = conn(:post, "/v1/events", @valid_attrs)
    |> put_req_header("content-type", "application/json")
    |> make_response

    assert conn.state == :sent
    assert conn.status == 200
  end

  test "PATCH /v1/events/:id", %{model: model} do
    conn = conn(:patch, "/v1/events/#{model.id}", %{status: 'inactive'})
    |> put_req_header("content-type", "application/json")
    |> make_response

    assert conn.state == :sent
    assert conn.status == 200
  end

  test "GET /v1/events/:id", %{model: model} do
    conn = conn(:get, "/v1/events/#{model.id}")
    |> put_req_header("content-type", "application/json")
    |> make_response
    assert conn.status == 200
  end

  test "GET /v1/events" do
    conn = conn(:get, "/v1/events")
    |> put_req_header("content-type", "application/json")
    |> make_response
    assert conn.state == :sent
    assert conn.status == 200
  end

  test "DELETE /v1/events/:id", %{model: model} do
    conn = conn(:delete, "/v1/events/#{model.id}")
    |> put_req_header("content-type", "application/json")
    |> make_response
    assert conn.status == 200
  end
end
