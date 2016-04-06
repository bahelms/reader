defmodule Mix.Tasks.StartApp do
  use Mix.Task

  def run(_args) do
    create_database

    IO.puts "Running migrate..."
    Mix.Task.run("ecto.migrate")

    IO.puts "Starting Phoenix server..."
    Mix.Task.run("phoenix.server")
  end

  def create_database do
    try do
      IO.puts "Running create..."
      Mix.Task.run("ecto.create")
    rescue
      _ -> create_database
    end
  end
end
