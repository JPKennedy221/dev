defmodule StudentPerformanceAnalyticsWeb.ReportCardTest do
  use StudentPerformanceAnalyticsWeb.ConnCase
  import Phoenix.Component
  import Phoenix.LiveViewTest

  test "renders report card with dynamic content" do
    html = render_component(StudentPerformanceAnalyticsWeb.ReportCard, title: "Sample Standard") do
      ~H"<p>Sample content inside report card</p>"
    end
    assert html =~ "Sample Standard"
    assert html =~ "Sample content inside report card"
  end
end
