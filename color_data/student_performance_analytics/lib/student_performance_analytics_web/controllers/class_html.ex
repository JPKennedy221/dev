defmodule StudentPerformanceAnalyticsWeb.ClassHTML do
  use StudentPerformanceAnalyticsWeb, :html
  import StudentPerformanceAnalyticsWeb.FormComponents

  embed_templates "class_html/*"

  def format_active_flag(is_active) do
    if is_active, do: "Yes", else: "No"
  end
end
