defmodule StudentPerformanceAnalyticsWeb.AssessmentComparisonLive do
  use Phoenix.LiveView
  alias StudentPerformanceAnalytics.Reports
  alias StudentPerformanceAnalyticsWeb.ReportCard

  def mount(_params, _session, socket) do
    {:ok, assign(socket, :assessment_data, [])}
  end

  def handle_params(params, _url, socket) do
    class_id = params["class_id"]
    unit_id = params["unit_id"]
    assessment_type_id = params["assessment_type_id"]

    data = Reports.get_assessment_comparison_report(class_id, unit_id, assessment_type_id)
    {:noreply, assign(socket, :assessment_data, data)}
  end
end
