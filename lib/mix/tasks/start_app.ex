defmodule Mix.Tasks.StartApp do
  use Mix.Task

  def run(_) do
    IO.puts "Running create..."
    Mix.Task.run("ecto.create")

    IO.puts "Running migrate..."
    Mix.Task.run("ecto.migrate")

    IO.puts "Starting Phoenix server..."
    Mix.Task.run("phoenix.server")
  end
end
