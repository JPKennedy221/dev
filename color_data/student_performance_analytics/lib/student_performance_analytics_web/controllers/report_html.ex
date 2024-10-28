defmodule StudentPerformanceAnalyticsWeb.ReportHTML do
  use StudentPerformanceAnalyticsWeb, :html
  import StudentPerformanceAnalyticsWeb.FormComponent
  embed_templates "report_html/*"

  def format_average_score(average) do
    :erlang.float_to_binary(average, decimals: 2)
  end

  def format_percentage(count, total) when total > 0 do
    percent = (count / total) * 100
    :erlang.float_to_binary(percent, decimals: 1) <> "%"
  end

  def format_percentage(_, _), do: "N/A"
end
