defmodule Cron.Mixfile do
  use Mix.Project

  def project do
    [app: :cron,
     version: "0.0.1",
     elixir: "~> 1.2",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     description: description,
     package: package,
     deps: deps]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    [applications: [:logger, :maru, :postgrex, :ecto, :scrivener_ecto,
        :httpoison, :quantum],
      mod: {Cron, []}
    ]
  end

  # Dependencies can be Hex packages:
  #
  #   {:mydep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:mydep, git: "https://github.com/elixir-lang/mydep.git", tag: "0.1.0"}
  #
  # Type "mix help deps" for more examples and options
  defp deps do
    [
      {:maru, "~> 0.10.5"},
      {:poison, "~> 3.0", override: true},
      {:cors_plug, "~> 1.1.1"},
      {:postgrex, "~> 0.12.1"},
      {:ecto, "~> 2.0.5"},
      {:scrivener_ecto, "~> 1.0"},
      {:exrm, "~> 1.0.5"},
      {:quantum, ">= 1.8.0"},
      {:httpoison, "~> 0.10.0"},
      {:dogma, "~> 0.1", only: [:dev, :test]},
    ]
  end

  defp description do
    """
    Cron-like job scheduler as a service
    """
  end

  defp package do
    [maintainers: ["Rafael Jesus"],
     licenses: ["Apache 2.0"],
     links: %{"GitHub" => "https://github.com/rafaeljesus/cron_api"},
     files: ~w(mix.exs README.md lib)]
  end
end
