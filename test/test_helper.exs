ExUnit.start

defmodule Test.TestHelper do
  def create_database do
    try do
      Mix.Task.run "ecto.create", ["--quiet"]
    rescue
      _ -> create_database
    end
  end
end

Test.TestHelper.create_database
Mix.Task.run "ecto.migrate", ["--quiet"]
Ecto.Adapters.SQL.Sandbox.mode(Reader.Repo, :manual)
