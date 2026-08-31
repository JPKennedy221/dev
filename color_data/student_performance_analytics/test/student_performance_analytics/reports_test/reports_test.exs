defmodule StudentPerformanceAnalytics.ReportsTest do
  use StudentPerformanceAnalytics.DataCase

  alias StudentPerformanceAnalytics.Reports

  setup do
    # Insert sample data for testing
    class = insert!(:class, name: "Math 101")
    unit = insert!(:unit, title: "Algebra Basics")
    standard = insert!(:standard, name: "Solving Equations")
    assessment_type = insert!(:assessment_type, name: "Unit Test")
    student = insert!(:student, name: "John Doe", class_id: class.id)

    %{class: class, unit: unit, standard: standard, assessment_type: assessment_type, student: student}
  end

  describe "get_assessment_comparison_report/3" do
    test "returns average scores per standard for a class", %{class: class, unit: unit, standard: standard, assessment_type: assessment_type} do
      insert!(:assessment, score: 3, class_id: class.id, unit_id: unit.id, standard_id: standard.id, assessment_type_id: assessment_type.id)
      insert!(:assessment, score: 2, class_id: class.id, unit_id: unit.id, standard_id: standard.id, assessment_type_id: assessment_type.id)

      result = Reports.get_assessment_comparison_report(class.id, unit.id, assessment_type.id)
      assert [%{standard: "Solving Equations", avg_score: 2.5}] = result
    end
  end

  describe "get_student_slip_report/2" do
    test "returns individual student performance across standards in a unit", %{student: student, unit: unit, standard: standard, assessment_type: assessment_type} do
      insert!(:assessment, score: 3, student_id: student.id, unit_id: unit.id, standard_id: standard.id, assessment_type_id: assessment_type.id)

      result = Reports.get_student_slip_report(student.id, unit.id)
      assert [%{standard: "Solving Equations", score: 3, assessment_type: ^assessment_type.id}] = result
    end
  end
end
