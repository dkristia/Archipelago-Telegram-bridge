defmodule ApTgBridge.MixProject do
  use Mix.Project

  def project do
    [
      app: :ap_tg_bridge,
      version: "0.1.0",
      elixir: "~> 1.14",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {ApTgBridge.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:nadia, "~> 0.7.0"},
      {:websockex, "~> 0.4.3"},
      {:jason, "~> 1.4.4"},
      {:uuid, "~> 1.1.0"}
    ]
  end
end
