defmodule Cron.SearchTest do
  use ExUnit.Case
  alias Cron.{Search}

  test "should create new searcheable struct" do
    page = Search.new %{}
    assert page.events == []
    assert page.page_number == 1
    assert page.page_size == 10
    assert page.total_pages == 0
  end
end
