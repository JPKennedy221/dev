defmodule StudentPerformanceAnalyticsWeb.StudentSlipLive do
  use Phoenix.LiveView
  alias StudentPerformanceAnalytics.Reports
  alias StudentPerformanceAnalyticsWeb.ReportCard

  def mount(_params, _session, socket) do
    {:ok, assign(socket, :student_performance, [])}
  end

  def handle_params(params, _url, socket) do
    student_id = params["student_id"]
    unit_id = params["unit_id"]

    data = Reports.get_student_slip_report(student_id, unit_id)
    {:noreply, assign(socket, :student_performance, data)}
  end
end
