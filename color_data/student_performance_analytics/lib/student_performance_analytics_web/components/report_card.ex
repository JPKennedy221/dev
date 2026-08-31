defmodule StudentPerformanceAnalyticsWeb.ReportCard do
  use Phoenix.Component

  attr :title, :string, required: true
  slot :content, required: true

  def render(assigns) do
    ~H"""
    <div class="report-card">
      <h2><%= @title %></h2>
      <div>
        <%= render_slot(@content) %>
      </div>
    </div>
    """
  end
end
