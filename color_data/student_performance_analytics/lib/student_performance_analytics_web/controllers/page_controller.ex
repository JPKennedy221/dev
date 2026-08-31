defmodule StudentPerformanceAnalyticsWeb.PageController do
  use StudentPerformanceAnalyticsWeb, :controller

  def index(conn, _params) do
    render(conn, StudentPerformanceAnalyticsWeb.PageHTML, "index.html")
  end
end
