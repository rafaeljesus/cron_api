defmodule Cron.Repo do
  use Ecto.Repo, otp_app: :cron, adapter: Mongo.Ecto
end
