defmodule StudentPerformanceAnalytics.Units.Unit do
  use Ecto.Schema
  import Ecto.Changeset

  schema "units" do
    field :title, :string

    has_many :standards, StudentPerformanceAnalytics.Standards.Standard
    has_many :assessments, StudentPerformanceAnalytics.Assessments.Assessment

    timestamps()
  end

  @doc false
  def changeset(unit, attrs) do
    unit
    |> cast(attrs, [:title])
    |> validate_required([:title])
  end
end
