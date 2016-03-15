defmodule JanrainGuardian.User do
  use JanrainGuardian.Web, :model

  schema "users" do
    field :name, :string
    field :identity, :string

    timestamps
  end

  @required_fields ~w(identity)
  @optional_fields ~w(name)

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end

  def new?(identity) do
    query = from u in JanrainGuardian.User, where: u.identity == ^identity
    JanrainGuardian.Repo.all(query)
    |> length == 0
  end
end
