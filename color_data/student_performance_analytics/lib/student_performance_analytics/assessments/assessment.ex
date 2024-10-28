defmodule StudentPerformanceAnalytics.Assessments.Assessment do
  use Ecto.Schema
  import Ecto.Changeset

  schema "assessments" do
    field :question_number, :integer
    field :score, :integer

    belongs_to :student, StudentPerformanceAnalytics.Students.Student
    belongs_to :class, StudentPerformanceAnalytics.Classes.Class
    belongs_to :unit, StudentPerformanceAnalytics.Units.Unit
    belongs_to :assessment_type, StudentPerformanceAnalytics.Assessments.AssessmentType

    timestamps()
  end

  @doc false
  def changeset(assessment, attrs) do
    assessment
    |> cast(attrs, [:student_id, :class_id, :unit_id, :assessment_type_id, :question_number, :score])
    |> validate_required([:student_id, :class_id, :unit_id, :assessment_type_id, :question_number, :score])
    |> validate_inclusion(:score, 1..3)
  end
end
