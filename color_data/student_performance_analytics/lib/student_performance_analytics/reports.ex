defmodule StudentPerformanceAnalytics.Reports do
  import Ecto.Query, warn: false
  alias StudentPerformanceAnalytics.Repo
  alias StudentPerformanceAnalytics.Assessments.Assessment
  alias StudentPerformanceAnalytics.Standards.Standard

  # Fetches the average score for each standard in a class for a specific assessment type.
  def get_assessment_comparison(class_id, unit_id, assessment_type_id) do
    from(a in Assessment,
      where: a.class_id == ^class_id and a.unit_id == ^unit_id and a.assessment_type_id == ^assessment_type_id,
      join: s in Standard, on: s.id == a.standard_id,
      group_by: s.name,
      select: %{standard: s.name, avg_score: avg(a.score)}
    )
    |> Repo.all()
  end

  # Fetches each student's performance on all standards in a unit.
  def get_student_slips(student_id, unit_id) do
    from(a in Assessment,
      where: a.student_id == ^student_id and a.unit_id == ^unit_id,
      join: s in Standard, on: s.id == a.standard_id,
      select: %{standard: s.name, score: a.score, assessment_type: a.assessment_type_id}
    )
    |> Repo.all()
  end

  def get_assessment_comparison_report(class_id, unit_id, assessment_type_id) do
    get_assessment_comparison(class_id, unit_id, assessment_type_id)
  end

  def get_student_slip_report(student_id, unit_id) do
    get_student_slips(student_id, unit_id)
  end

end
