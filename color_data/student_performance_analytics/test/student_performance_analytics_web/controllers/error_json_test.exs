defmodule StudentPerformanceAnalyticsWeb.ErrorJSONTest do
  use StudentPerformanceAnalyticsWeb.ConnCase, async: true

  test "renders 404" do
    assert StudentPerformanceAnalyticsWeb.ErrorJSON.render("404.json", %{}) == %{errors: %{detail: "Not Found"}}
  end

  test "renders 500" do
    assert StudentPerformanceAnalyticsWeb.ErrorJSON.render("500.json", %{}) ==
             %{errors: %{detail: "Internal Server Error"}}
  end
end
