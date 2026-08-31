defmodule StandardData.Assessment_Type do
  use Ecto.Schema
  import Ecto.Changeset

  schema "assessment_types" do
    field :name, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(assessment_type, attrs) do
    assessment_type
    |> cast(attrs, [:id, :name])
    |> validate_required([:id, :name])
  end
end
