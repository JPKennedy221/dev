defmodule StandardData.Unit do
  use Ecto.Schema
  import Ecto.Changeset

  schema "units" do
    field :name, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(unit, attrs) do
    unit
    |> cast(attrs, [:name, :id])
    |> validate_required([:name, :id])
  end
end
