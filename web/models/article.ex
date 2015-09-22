defmodule Reader.Article do
  use Reader.Web, :model
  import Ecto.Query

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

  def articles_by_category do
    __MODULE__
      |> order_by([a], a.category)
  end

  def distinct_categories do
    __MODULE__
      |> group_by([a], a.category)
      |> select([a], a.category)
  end

  def in_category(query \\ __MODULE__, category) do
    where(query, [a], a.category == ^category)
  end

  def unread(query \\ __MODULE__) do
    where(query, [a], a.read == false)
  end
end

