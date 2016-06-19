use Mix.Config

config :maru, Cron.API,
  versioning: [
    using: :path
  ],
  http: [port: 3000]

config :cron, Cron.Repo,
  database: "cron_test",
  hostname: "localhost"
