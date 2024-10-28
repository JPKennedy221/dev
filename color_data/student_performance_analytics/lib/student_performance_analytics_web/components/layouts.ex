defmodule StudentPerformanceAnalyticsWeb.Layouts do
  use Phoenix.Component
  import Phoenix.HTML.Link

  def app_layout(assigns) do
    ~H"""
    <header>
      <nav>
        <%= link "Home", to: Routes.page_path(@conn, :index) %> |
        <%= link "Classes", to: Routes.class_path(@conn, :index) %> |
        <%= link "Reports", to: Routes.report_path(@conn, :index) %>
      </nav>
    </header>
    <main>
      <%= render_slot(@inner_content) %>
    </main>
    <footer>
      <p>&copy; 2024 Student Performance Analytics</p>
    </footer>
    """
  end
end
