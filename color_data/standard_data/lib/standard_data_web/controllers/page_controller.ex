defmodule StandardDataWeb.PageController do
  use StandardDataWeb, :controller

  def home(conn, params) do
    # The home page is often custom made,
    # so skip the default app layout.
    render(conn, :home, layout: false, page_title: "Standard Performance")
  end
end
