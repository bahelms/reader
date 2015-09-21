defmodule Reader.HomeView do
  use Reader.Web, :view

  def downcase(string) do
    String.downcase(string)
  end
end

