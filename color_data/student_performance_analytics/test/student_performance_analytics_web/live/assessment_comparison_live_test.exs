defmodule StudentPerformanceAnalyticsWeb.AssessmentComparisonLiveTest do
  use StudentPerformanceAnalyticsWeb.ConnCase
  import Phoenix.LiveViewTest

  alias StudentPerformanceAnalytics.Reports

  setup do
    # Insert sample data for testing
    class = insert!(:class, name: "Math 101")
    unit = insert!(:unit, title: "Algebra Basics")
    assessment_type = insert!(:assessment_type, name: "Unit Test")
    standard = insert!(:standard, name: "Solving Equations")
    %{class: class, unit: unit, assessment_type: assessment_type, standard: standard}
  end

  test "renders assessment comparison report", %{conn: conn, class: class, unit: unit, assessment_type: assessment_type} do
    {:ok, view, _html} = live(conn, Routes.live_path(conn, StudentPerformanceAnalyticsWeb.AssessmentComparisonLive, class.id, unit.id, assessment_type.id))
    assert view |> element(".report-card") |> has_text?("Solving Equations")
  end
end
