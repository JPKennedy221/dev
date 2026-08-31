defmodule StudentPerformanceAnalyticsWeb.StudentSlipLiveTest do
  use StudentPerformanceAnalyticsWeb.ConnCase
  import Phoenix.LiveViewTest

  alias StudentPerformanceAnalytics.Reports

  setup do
    # Insert sample data for testing
    student = insert!(:student, name: "John Doe")
    unit = insert!(:unit, title: "Algebra Basics")
    standard = insert!(:standard, name: "Solving Equations")
    assessment_type = insert!(:assessment_type, name: "Unit Test")
    %{student: student, unit: unit, standard: standard, assessment_type: assessment_type}
  end

  test "renders student slip report", %{conn: conn, student: student, unit: unit} do
    {:ok, view, _html} = live(conn, Routes.live_path(conn, StudentPerformanceAnalyticsWeb.StudentSlipLive, student.id, unit.id))
    assert view |> element(".report-card") |> has_text?("Solving Equations")
  end
end
