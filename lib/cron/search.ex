defmodule Cron.Search do
  alias Cron.{Event, Paginator}

  def new(params) do
    page = Event |> Paginator.new(params)
    %{
      events: page.entries,
      page_number: page.page_number,
      page_size: page.page_size,
      total_pages: page.total_pages,
    }
  end
end
