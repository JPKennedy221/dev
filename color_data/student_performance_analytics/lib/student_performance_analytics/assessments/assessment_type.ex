defmodule StudentPerformanceAnalytics.Assessments.AssessmentType do
  use Ecto.Schema
  import Ecto.Changeset

  schema "assessment_types" do
    field :name, :string

    has_many :assessments, StudentPerformanceAnalytics.Assessments.Assessment

    timestamps()
  end

  @doc false
  def changeset(assessment_type, attrs) do
    assessment_type
    |> cast(attrs, [:name])
    |> validate_required([:name])
    |> unique_constraint(:name)
  end
end
