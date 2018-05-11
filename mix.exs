defmodule ExmachinaExample.Mixfile do
  use Mix.Project

  def project do
    [
      app: :exmachina_example,
      version: "0.1.0",
      elixir: "~> 1.4",
     build_embedded: Mix.env == :prod,      
      start_permanent: Mix.env == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger], 
      mod: {ExMachinaExample, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:exmachina, git: "https://github.com/gabrielrivas/exmachina.git"}

      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"},
    ]
  end
end
