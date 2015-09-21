defmodule Reader.Article do
  use Reader.Web, :model

  schema "articles" do
    field :url, :string
    field :category, :string
    field :title, :string
    field :read, :boolean, default: false
    field :favorite, :boolean, default: false

    timestamps
  end

  @required_fields ~w(url category)
  @optional_fields ~w(title read favorite)

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end
end
