defmodule StudentPerformanceAnalytics.Assessments do
  import Ecto.Query, warn: false
  alias StudentPerformanceAnalytics.Repo
  alias StudentPerformanceAnalytics.Assessments.{Assessment, AssessmentType}

  def list_assessments do
    Repo.all(Assessment)
  end

  def get_assessment!(id) do
    Repo.get!(Assessment, id)
  end

  def create_assessment(attrs \\ %{}) do
    %Assessment{}
    |> Assessment.changeset(attrs)
    |> Repo.insert()
  end

  def update_assessment(%Assessment{} = assessment, attrs) do
    assessment
    |> Assessment.changeset(attrs)
    |> Repo.update()
  end

  def delete_assessment(%Assessment{} = assessment) do
    Repo.delete(assessment)
  end

  def change_assessment(%Assessment{} = assessment) do
    Assessment.changeset(assessment, %{})
  end

  def list_assessment_types do
    Repo.all(AssessmentType)
  end

  def get_comparison_report(class_id, assessment_type_id) do
    query = from a in Assessment,
      where: a.class_id == ^class_id and a.assessment_type_id == ^assessment_type_id,
      join: s in assoc(a, :standard),
      group_by: s.id,
      select: %{
        standard: s,
        average_score: avg(a.score),
        exceeding_count: count(a.id, a.score == 3),
        meeting_count: count(a.id, a.score == 2),
        approaching_count: count(a.id, a.score == 1),
        total_count: count(a.id)
      }

    Repo.all(query)
  end

  def get_student_slips(class_id) do
    query = from s in Student,
      where: s.class_id == ^class_id,
      preload: [assessments: [:standard, :assessment_type]],
      select: %{student: s, assessments: s.assessments}

    Repo.all(query)
  end

end
