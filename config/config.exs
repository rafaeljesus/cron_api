use Mix.Config

config :maru, Cron.API,
  versioning: [
    using: :path
  ],
  http: [port: 3000]

config :logger,
  backends: [:console],
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :cron, ecto_repos: [Cron.Repo]

config :cron, Cron.Repo,
  adapter: Ecto.Adapters.Postgres,
  url: {:system, "CRON_API_URL"}
