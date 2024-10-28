defmodule StudentPerformanceAnalytics.Standards.Standard do
  use Ecto.Schema
  import Ecto.Changeset

  schema "standards" do
    field :description, :string

    belongs_to :unit, StudentPerformanceAnalytics.Units.Unit

    timestamps()
  end

  @doc false
  def changeset(standard, attrs) do
    standard
    |> cast(attrs, [:description, :unit_id])
    |> validate_required([:description, :unit_id])
  end
end
