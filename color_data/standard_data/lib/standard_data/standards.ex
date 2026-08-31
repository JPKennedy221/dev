defmodule StandardData.Standard do
  use Ecto.Schema
  import Ecto.Changeset

  schema "standards" do
    field :name, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(standards, attrs) do
    standards
    |> cast(attrs, [:id, :name])
    |> validate_required([:id, :name])
  end
end
