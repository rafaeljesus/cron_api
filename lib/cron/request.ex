defmodule Cron.Request do
  def call(url) do
    url
    |> HTTPoison.get
    |> handle
  end

  defp handle({:ok, %{status_code: 200} = response}), do: {:ok, response}
  defp handle({:error, error}), do: {:error, :unfetchable}
end
